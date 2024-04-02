import express from 'express';
const router = express.Router();
import {pool} from '../../server.js';

router.post('', async (req, res) => {
  if (!req.session.isLoggedIn || req.session.category !== 'admin') {
    res.status(403).json({error: 'Accès refusé'});
    return;
  }

  try {
    //get the usersToRenew table
    const [usersToRenewResults] = await pool.query(
      'SELECT * FROM usersToRenew'
    );

    //get the users table
    const [usersResults] = await pool.query('SELECT * FROM user');

    //delete the grades for every user in the user table except for the ones in the usersToRenew table in which case, give them the appropriate grade
    for (const user of usersResults) {
      const userToRenew = usersToRenewResults.find(
        (userToRenew) => userToRenew.user === user.email
      );

      if (userToRenew) {
        //give the user the appropriate grade
        const grade = userToRenew.grade;

        await pool.query('UPDATE user SET grade = ? WHERE email = ?', [
          grade,
          user.email,
        ]);
      } else {
        //delete the grade
        await pool.query('UPDATE user SET grade = NULL WHERE email = ?', [
          user.email,
        ]);
      }
    }

    //empty the usersToRenew table
    await pool.query('DELETE FROM usersToRenew');

    res.status(200).json({success: true});
  } catch (err) {
    res.status(500).json({error: 'Une erreur est survenue'});
  }
});

export default router;
