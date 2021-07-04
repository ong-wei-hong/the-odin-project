function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function multiply(a, b) {
    return a * b;
}

function divide(a, b) {
    return a / b;
}

function operate(a, operator, b) {
    switch(operator) {
        case '+':
            return add(a, b);
        case '-':
            return subtract(a, b);
        case '*':
            return multiply(a, b);
        case '/':
            return divide(a, b);
        default:
            return 'UNKNOWN ERROR';
    }
}

//insert the buttons
const buttons = document.querySelector('#buttons');
const buttonLabels = ['Escape', 'Delete', '/', 7, 8, 9, '*', 4, 5, 6, '-', 1, 2, 3, '+', 0, '.', 'Enter'];
for(let i in buttonLabels) {
    const button = document.createElement("button");
    button.textContent = buttonLabels[i];
    button.id = `${(buttonLabels[i] === '=') ? 'equal' : buttonLabels[i]}-button`;
    button.classList.add('button')
    buttons.appendChild(button);
}

//logic starts here
const screen = document.getElementById('screen');
let previousValue = '', previousOperator = '', clearScreenOnNextNumber = false;

function reset() {
    screen.textContent = '0';
    previousValue = '';
    previousOperator = '';
    clearScreenOnNextNumber = false;
    document.querySelectorAll('.operator').forEach((e) => {
        e.style.color = '#FFF';
    })
}

function errorMessage(message) {
    let store = screen.textContent;
    screen.textContent = `ERROR ${message}`;
    document.querySelectorAll('button').forEach(element => {
        element.disabled = true;
    });
    setTimeout(() => {
        screen.textContent = store;
        document.querySelectorAll('button').forEach(element => {
            element.disabled = false;
        });
    }, 1000);
}

for(let i=0; i<=9; ++i) {
    const button = document.getElementById(`${i}-button`);
    button.addEventListener('click', () => {
        document.querySelectorAll('.operator').forEach((e) => {
            e.style.color = '#FFF';
        })
        if(clearScreenOnNextNumber) {
            clearScreenOnNextNumber = false;
            if(previousOperator){
                previousValue = parseFloat(screen.textContent);
            }
            screen.textContent = '0';
        }
        if(screen.textContent === '0') {
            screen.textContent = button.textContent;
            return;
        }
        if(screen.textContent.length === 15) {
            return errorMessage('MAX DIGIT LIMIT');
        }
        screen.textContent += button.textContent;
    })
}

const operatorList = ['/', '*', '+', '-'];
for (let i in operatorList){
    const button = document.getElementById(`${operatorList[i]}-button`);
    button.classList.add('operator');
    button.addEventListener('click', () => {
        if(previousOperator === '/' && screen.textContent === '0') {
            return errorMessage('DIVIDE BY 0');
        }
        if(previousOperator && typeof previousValue === 'number') {
            let store = operate(previousValue, previousOperator, parseFloat(screen.textContent)).toString();
            if(store.length > 15) {
                store = store.slice(0, 15);
            }
            screen.textContent = store;
            previousValue = '';
        }
        previousOperator = operatorList[i];
        document.querySelectorAll('.operator').forEach((e) => {
            e.style.color = '#FFF';
        })
        button.style.color = '#000';
        clearScreenOnNextNumber = true;
    })
}

const equalButton = document.getElementById('Enter-button');
equalButton.textContent = '= (Enter)';
equalButton.addEventListener('click', () => {
    if(previousOperator === '/' && screen.textContent === '0') {
        return errorMessage('DIVIDE BY 0');
    }
    if(previousOperator && typeof previousValue === 'number') {
        let store = operate(previousValue, previousOperator, parseFloat(screen.textContent)).toString();
        reset();
        if(store.length > 15) {
            store = store.slice(0, 15);
        }
        screen.textContent = store;
        clearScreenOnNextNumber = true;
    }else if(previousOperator == '') {       
        return errorMessage('MISSING OPERATOR');
    }else if(typeof previousValue !== 'number') {
        return errorMessage('MISSING SECOND VALUE');
    }
})

const ACButton = document.getElementById('Escape-button');
ACButton.addEventListener('click', () => {
    reset();
})
ACButton.textContent = 'AC (ESC)';

const decimalButton = document.getElementById('.-button');
decimalButton.addEventListener('click', () => {
    if(clearScreenOnNextNumber) {
        clearScreenOnNextNumber = false;
        if(previousOperator){
            previousValue = parseFloat(screen.textContent);
        }
        screen.textContent = '0';
    }
    if(screen.textContent.search(/\./) !== -1) {
        return errorMessage('MAX DECIMAL')
    }
    if(screen.textContent.length === 15) {
        return errorMessage('MAX DIGIT LIMIT');
    }
    screen.textContent += '.';
    document.querySelectorAll('.operator').forEach((e) => {
        e.style.color = '#FFF';
    })
})

const delButton = document.getElementById('Delete-button');
delButton.textContent = 'DEL';
delButton.addEventListener('click', () => {
    if(screen.textContent === '0') {
        return errorMessage('ALL DELETED');
    }else if(screen.textContent.length === 1) {
        screen.textContent = '0';
        return;
    }
    screen.textContent = screen.textContent.slice(0, screen.textContent.length-1);
    clearScreenOnNextNumber = false;
    if(screen.textContent === '-') {
        screen.textContent = '0';
    }
})
//initialisation
reset();

//add window event listeners
window.addEventListener('keyup', e => {
    buttonLabels.forEach(button => {
        if(e.key === button.toString()) {
            e.preventDefault();
            let curr = document.getElementById(`${button}-button`);
            curr.click();
        }
    })
})