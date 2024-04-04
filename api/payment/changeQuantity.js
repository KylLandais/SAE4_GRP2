import express from 'express';

const router = express.Router();

router.get('', async (req, res) => {
    const itemsToSend = [];

    if (
        !req.session.isLoggedIn ||
        !req.session.cart ||
        req.session.cart.length === 0
    ) {
        res.status(403).json({error: 'Accès refusé'});
        return;
    }

    const cart = req.session.cart || [];
    const item = cart[req.body.items[1]]

    let total = req.body.items[2] - (item.quantity * item.price)

    req.session.cart[req.body.items[1]].quantity = req.body.items[0]

    total = total + (req.body.items[0] * item.price)
    total = total.toFixed(2)
    
    itemsToSend.push({
        price: Number((req.body.items[0] * item.price)),
        total: `Total: ${total}€`
    });

    res.status(200).json({success: true, items: itemsToSend});
});
export default router;