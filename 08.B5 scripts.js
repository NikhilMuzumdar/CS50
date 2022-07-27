// Personalized welcome message code

let myButton = document.querySelector('button');
let myHeading = document.querySelector('h2');

function setUserName() {
   let myName = prompt('Please enter your name.');

   if (!myName) {
      setUserName();
   } else {
      localStorage.setItem('name', myName);
      myHeading.innerHTML = 'Hello ' + myName + ", aren't these facts about space animals facinating?";
   }
}

if (!localStorage.getItem('name')) {
   setUserName();
} else {
   let storedName = localStorage.getItem('name');
   myHeading.innerHTML = 'Hello ' + storedName + ", aren't these facts about space animals facinating?";
}

myButton.onclick = function () {
   setUserName();
}