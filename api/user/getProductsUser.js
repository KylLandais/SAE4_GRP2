import express from 'express';
const router = express.Router();
import {pool} from '../../server.js';

router.get('', async (req, res) => {
  if (!req.session.isLoggedIn || req.session.email === undefined) {
    res.status(200).json({success: true, events: []});
    return;
  }

  const [userProducts] = await pool.query(
    'SELECT product.name, product.price FROM user INNER JOIN transaction ON user.email = transaction.email INNER JOIN transactionContent ON transaction.transaction_id = transactionContent.transaction_id INNER JOIN product ON transactionContent.product_id = product.id WHERE user.email = ?',
    [req.session.email],
    (err) => {
      if (err) {
        console.error('Impossible de récupérer les produits :', err);
        res.status(500).json({error: 'Impossible de récupérer les produits'});
        return;
      }
    }
  );

  let bool = true
  if (userProducts.length == 0){
    bool = false
  }

  res.status(200).json({success: bool, products: userProducts});
});

export default router;