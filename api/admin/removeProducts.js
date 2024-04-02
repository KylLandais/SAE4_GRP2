import express from 'express';
const router = express.Router();
import {pool} from '../../server.js';

router.post('', async (req, res) => {
  const {productId} = req.body;
  if (!req.session.isLoggedIn || req.session.category !== 'admin') {
    res.status(403).json({error: 'Accès refusé'});
    return;
  }

  if (confirm('Voulez vous vraiment supprimer ce produit ?')) {
    await pool.query(
        'DELETE FROM product WHERE id = ?',
        [productId],
        (err) => {
          if (err) {
            console.error('Impossible de supprimer le produit :', err);
            res.status(500).json({error: 'Impossible de supprimer le produit'});
            return;
          }
        }
    );
  }
});

export default router;
