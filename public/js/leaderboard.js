const leaderboard = document.querySelector('#xpLeaderboardContainer');

fetch('/api/user/leaderboard')
  .then((res) => res.json())
  .then((data) => {
    if (data.error) {
      leaderboard.innerHTML = `<p class="error">${data.error}</p>`;
    } else {
      let max_xp = 0;

      data.forEach((user) => {
        if (user.xp > max_xp) {
          max_xp = user.xp;
        }
      });

      data.forEach((user, index) => {
        const xp_width = (user.xp / max_xp) * 100 + '%';

        if (user.dc_pfp == null || user.dc_pfp == '') {
          var pfp = 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';
          leaderboard.innerHTML += `
            <div class="leaderboardUser">
                <p class="leaderboardUserRank">${index + 1}</p>
                <span class="leaderboardUserSpan">
                  <img class="leaderboardUserPfp" src="${pfp}" alt="pfp">
                  <p class="leaderboardUserPseudo">${user.username.replace(/[<>]/gi, '')}</p>
                </span>

                <p class="leaderboardUserScore" style="--xp_bar_width: ${xp_width};">${
            user.xp
          }</p>
                <p class="leaderboardUserCategory">${user.category}</p>
            </div>
        `;
        } else {
          var pfp = `https://cdn.discordapp.com/avatars/${user.dc_id}/${user.dc_pfp}.png`;
          //test to see if the image exists
          fetch(pfp)
            .then((res) => {
              if (res.status === 404) {
                // If the image returns a 404 status, set a default image URL
                pfp = 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png';
              }
            })
            .catch((err) => {
              console.error('erreur', err);
            })
            .finally(() => {
              // Update the image src after the fetch request is complete
              leaderboard.innerHTML += `
            <div class="leaderboardUser">
                <p class="leaderboardUserRank">${index + 1}</p>
                <span class="leaderboardUserSpan">
                  <img class="leaderboardUserPfp" src="${pfp}" alt="pfp">
                  <p class="leaderboardUserPseudo">${user.username}</p>
                </span>

                <p class="leaderboardUserScore" style="--xp_bar_width: ${xp_width};">${
                user.xp
              }</p>
                <p class="leaderboardUserCategory">${user.category}</p>
            </div>
        `;
            });
        }
      });
    }
  });

function sortByName() {
  const leaderboardUsers = document.querySelectorAll(
    '.leaderboardUser:not(.bold)'
  );
  const leaderboardUsersArray = Array.from(leaderboardUsers);

  leaderboardUsersArray.sort((a, b) => {
    const aName = a.querySelector('.leaderboardUserPseudo').innerText;
    const bName = b.querySelector('.leaderboardUserPseudo').innerText;

    if (aName < bName) {
      return -1;
    } else if (aName > bName) {
      return 1;
    } else {
      return 0;
    }
  });

  leaderboardUsersArray.forEach((user, index) => {
    leaderboard.appendChild(user);
  });
}

function filterByName(query) {
  const leaderboardUsers = document.querySelectorAll(
    '.leaderboardUser:not(.bold)'
  );
  const leaderboardUsersArray = Array.from(leaderboardUsers);

  leaderboardUsersArray.forEach((user) => {
    const pseudo = user.querySelector('.leaderboardUserPseudo').innerText;

    if (pseudo.toLowerCase().includes(query.toLowerCase())) {
      user.style.display = 'grid';
    } else {
      user.style.display = 'none';
    }
  });
}

function sortByXp() {
  const leaderboardUsers = document.querySelectorAll(
    '.leaderboardUser:not(.bold)'
  );
  const leaderboardUsersArray = Array.from(leaderboardUsers);

  leaderboardUsersArray.sort((a, b) => {
    const aXp = a.querySelector('.leaderboardUserScore').innerText;
    const bXp = b.querySelector('.leaderboardUserScore').innerText;

    return bXp - aXp;
  });

  leaderboardUsersArray.forEach((user, index) => {
    leaderboard.appendChild(user);
  });
}

function sortByCategory() {
  const leaderboardUsers = document.querySelectorAll(
    '.leaderboardUser:not(.bold)'
  );
  const leaderboardUsersArray = Array.from(leaderboardUsers);

  leaderboardUsersArray.sort((a, b) => {
    const aCategory = a.querySelector('.leaderboardUserCategory').innerText;
    const bCategory = b.querySelector('.leaderboardUserCategory').innerText;

    if (aCategory < bCategory) {
      return -1;
    } else if (aCategory > bCategory) {
      return 1;
    } else {
      return 0;
    }
  });

  leaderboardUsersArray.forEach((user, index) => {
    leaderboard.appendChild(user);
  });
}

//on load, sort by xp
document.addEventListener('DOMContentLoaded', () => {
  setTimeout(() => {
    sortByXp();
  }, 300);
});
