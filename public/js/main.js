// Function to handle form submission for login
var urlParams = new URLSearchParams(window.location.search);
var returnUrl = urlParams.get('returnUrl') || '/';

const registerForm = document.querySelector('.registerForm:not(.nonInfo');
const nonInfoRegisterForm = document.querySelector('.registerForm.nonInfo');

function hashPass(password) {
  /*var hash = 0,
    i,
    chr;

  for (i = 0; i < password.length; i++) {
    chr = password.charCodeAt(i);
    hash = (hash << 5) - hash + chr;
    hash |= 0; // Convert to 32bit integer
  }*/
  const hashValue = password =>
  crypto.subtle
    .digest('SHA-256', new TextEncoder('utf-8').encode(password))
    .then(h => {
      let hexes = [],
        view = new DataView(h);
      for (let i = 0; i < view.byteLength; i += 4)
        hexes.push(('00000000' + view.getUint32(i).toString(16)).slice(-8));
      return hexes.join('');
    });

    let value = hashValue(JSON.stringify({ a: 'a', b: [1, 2, 3, 4], foo: { c: 'bar' } })).then(console.log)
    console.log(value);
    return value

}

document.getElementById('loginForm').addEventListener('submit', (e) => {
  e.preventDefault();

  const username = document.getElementById('loginUsername').value;
  var password = document.getElementById('loginPassword').value;
  // Hash the password before sending it to the server
  password = hashPass(password);

  // Make a POST request to the login endpoint
  fetch('/api/account/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({username, password}),
  })
    .then((response) => {
      if (response.status === 401) {
        userAlert('Identifiants incorrects');
      } else {
        window.location.href = returnUrl; // Redirect to the returned URL
      }
    })
    .then((data) => {
      if (data && data.error) {
        // Display error message to the user
        console.error(data.error);

        console.log('there was an error when logging in');
      }
    })
    .catch((error) => {
      console.error('Error:', error);
    });
});

async function sendChckCodeFetch() {
  const passcode = document.getElementById('passcode').value;
  const email = document.getElementById('email').value;

  const passcodeResponse = await fetch('/api/account/checkPasscode', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({passcode, email}),
  });

  if (passcodeResponse.status === 403) {
    userAlert('Mauvais code, merci de réessayer');
  } else window.location.reload();
}

if (registerForm.classList.contains('emailSubmit')) {
  registerForm.addEventListener('submit', async (e) => {
    // Note the async keyword here
    e.preventDefault();

    const email = document.getElementById('email').value;

    try {
      const response = await fetch('/api/account/verifyEmail', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({email}),
      });

      if (response.status === 409) {
        userAlert('Adresse mail déjà utilisée');
      } else if (response.status === 403) {
        userAlert(
          'Si vous réésayez, votre compte sera bani et vous serez signalé au département'
        );
      } else if (response.status === 400) {
        userAlert('Email invalide');
      } else {
        // Pop up to say that the email has been sent and input for the passcode

        //add the passcode input and submit button
        const passcodeInput = document.createElement('input');
        passcodeInput.setAttribute('type', 'text');
        passcodeInput.setAttribute('id', 'passcode');
        passcodeInput.setAttribute('placeholder', 'Code de vérification');
        passcodeInput.setAttribute('required', 'true');
        document.getElementById('emailFormInputs').appendChild(passcodeInput);

        const checkEmailButton = document.getElementById('validateEmailButton');
        checkEmailButton.setAttribute('type', 'button');
        checkEmailButton.setAttribute('onclick', 'sendChckCodeFetch()');
        checkEmailButton.setAttribute('value', 'Vérifier le code');
      }
    } catch (error) {
      console.error('Error:', error);
    }
  });
} else {
  registerForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const username = document.getElementById('username').value;
    var password = document.getElementById('registerPassword').value;
    // Hash the password before sending it to the server
    password = hashPass(password);

    const category = document.getElementById('category').value;

    // Make a POST request to the register endpoint
    fetch('/api/account/register', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({username, password, category}),
    })
      .then((response) => {
        if (response.status === 403) {
          userAlert(
            'Si vous réésayez, votre compte sera bani et vous serez signalé au département'
          );
        } else if (response.status === 409) {
          userAlert('Adresse mail déjà utilisée');
        } else if (response.status === 500) {
          userAlert(
            'Impossible de créer le compte, merci de réessayer plus tard'
          );
        } else {
          window.location.href = returnUrl; // Redirect to the returned URL
        }
      })
      .then((data) => {
        if (data && data.error) {
          // Display error message to the user
          console.error(data.error);

          console.log('there was an error when registering');
        }
      })
      .catch((error) => {
        console.error('Error:', error);
      });
  });
}

nonInfoRegisterForm.addEventListener('submit', (e) => {
  e.preventDefault();

  const name = document.getElementById('name').value;

  fetch('/api/account/nonInfoRegister', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({name}),
  }).then((response) => {
    if (response.status === 409) {
      userAlert('Nom déjà utilisé');
    } else if (response.status === 200) {
      window.location.href = returnUrl;
    }
  });
});
// Function to handle form submission for registration
