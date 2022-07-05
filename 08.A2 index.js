// Function to wait for the DOM to load
document.addEventListener('DOMContentLoaded', function()
{
// When correct answer is clicked, change color to green
let correct = document.querySelector('.correct');
correct.addEventListener('click', function()
{
    correct.style.backgroundColor = "green";
    document.querySelector('#feedback1').innerHTML = "Correct";
});

// When wrong answer is clicked, change color to red
let incorrect = document.querySelectorAll('.incorrect');
for (let i = 0; i < incorrect.length; i++)
{
    incorrect[i].addEventListener('click', function()
    {
        incorrect[i].style.backgroundColor = "red";
        document.querySelector('#feedback1').innerHTML = "Incorrect";
    });
}

// Check free response submission
document.querySelector('#check-answer').addEventListener('click', function()
{
    let input = document.querySelector('input');
    if (input.value === "Russia")
    {
        input.style.backgroundColor = "#71D67A";
        document.querySelector('#feedback2').innerHTML = "Correct, The largest country in the world is Russia with a total area of 17,098,242 Km² (6,601,665 mi²) and a land area of 16,376,870 Km² (6,323,142 mi²), equivalent to 11% of the total world's landmass of 148,940,000 Km² (57,510,000 square miles).";

    }
    else
    {
        input.style.backgroundColor = "#FA7D6B";
        document.querySelector('#feedback2').innerHTML = "Incorrect answer";
    }

})

});