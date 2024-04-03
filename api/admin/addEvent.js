import express from 'express';
import multer from 'multer';
import fs from 'fs';

console.log('feur')
var storage = multer.diskStorage({
  destination: './public/images/events/',
  filename: function (req, file, cb) {
    cb(
      null,
      file.fieldname + '-' + Date.now() + '.' + file.mimetype.split('/')[1]
    );
  },
});
const upload = multer({storage: storage});
const router = express.Router();

import {pool} from '../../server.js';

router.post('', upload.single('image'), async (req, res) => {
  try {
    if (!req.session.isLoggedIn || req.session.category !== 'admin') {
      //delete the uploaded file
      if (req.file) {
        fs.unlinkSync(req.file.path);
      }
      res.redirect('/login?returnUrl=/admin/events');
      return;
    }

    if (req.body.length === 0) {
      res.status(403).json({success: false, message: 'No data provided'});
      return;
    }
    //extract data from multipart form
    var {
      name,
      price,
      date,
    } = req.body;

    //check all the fields are filled
    if (
      name === '' ||
      price === '' ||
      date === ''
    ) {
      //delete the uploaded file
      if (req.file) {
        fs.unlinkSync(req.file.path);
      }
      res.status(403).json({success: false, message: 'Missing data'});
      return;
    }

    //sanitize the price, name and description
    price = price.replace(',', '.');
    name = name.trim();

    // Check if file was uploaded
    if (!req.file) {
      //send error message
      res.status(403).json({success: false, message: 'No image provided'});
    } else {
      // Access the uploaded file
      const uploadedFile = req.file;

      // Check if file is an image
      if (!uploadedFile.mimetype.startsWith('image/')) {
        //delete the uploaded file
        if (req.file) {
          fs.unlinkSync(req.file.path);
        }
        res
          .status(403)
          .json({success: false, message: "Le fichier n'est pas une image"});
        return;
      } else {
        var imageName = uploadedFile.filename;

        //add product with image
        await pool
          .query(
            'INSERT INTO event (name, price, date, image) VALUES (?, ?, ?, ?)',
            [
              name,
              price,
              date,
              `${imageName}`
            ]
          )
          .then(async () => {
            const [product] = await pool.query(
              'SELECT * FROM event WHERE name = ?',
              [name]
            );
            res.status(200).json({success: true, message: 'Event ajouté'});
          })
          .catch((err) => {
            //delete the uploaded file
            if (req.file) {
              fs.unlinkSync(req.file.path);
            }
            console.error(
              'Erreur lors du traitement des requêtes SQL d ajout de produit:',
              err
            );
            // Gérer l'erreur comme vous le souhaitez
            res.status(500).json({success: false, message: err});
            return;
          });
      }
    }
  } catch (err) {
    console.error('Erreur lors de l ajout du produit :', err);
    // Gérer l'erreur comme vous le souhaitez
    res.status(500).json({success: false, message: err});
  }
});

export default router;
