const elements = ['Rock', 'Paper', 'Scissors']

let computerScore = 0, playerScore = 0;

function computerPlay() {
    return elements[Math.floor(Math.random()*3)]
}

function win(winner) {
    document.querySelector('#winner').textContent = `${winner} wins!`;
    document.querySelectorAll('.option').forEach(btn => {
        btn.disabled = true;
    })
    document.querySelector('#reset').classList.remove('invisible');
}

function playRound(playerSelection, computerSelection) {
    let p=playerSelection[0], c=computerSelection[0]
    if((p === 'R' && c === 'P') || (p === 'P' && c === 'S') || (p === 'S' && c === 'R')) {
        ++computerScore;
        if(computerScore === 5) win("Computer");
        return `You Lose! ${computerSelection} beats ${playerSelection}`
    }
    if(p !== c) {
        ++playerScore;
        if(playerScore === 5) win("Player");
        return `You Win! ${playerSelection} beats ${computerSelection}`
    }
    return `Draw! ${playerSelection} does not beat ${computerSelection}`
}

document.querySelectorAll('.option').forEach(btn => {
    btn.addEventListener('click', e => {
        document.querySelector('#result').textContent = playRound(e.target.textContent, computerPlay());
        document.querySelector('#scores').textContent = `${playerScore} : ${computerScore}`;
    })
})

document.querySelector('#scores').textContent = `${playerScore} : ${computerScore}`;

document.querySelector('#reset').addEventListener('click', e => {
    document.querySelector('#winner').textContent = '\u00A0';
    playerScore = computerScore = 0;
    document.querySelector('#scores').textContent = `${playerScore} : ${computerScore}`;
    document.querySelectorAll('.option').forEach(btn => {
        btn.disabled=false;
    })
    document.querySelector('#reset').classList.add('invisible');
})

