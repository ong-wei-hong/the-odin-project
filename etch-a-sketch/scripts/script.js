const windowWidth = window.innerWidth;
const windowHeight = window.innerHeight/2.2;
const drawingLength = Math.min(windowWidth, windowHeight);

let n=16;
let l = drawingLength/n;
const container = document.querySelector('.container');

function darken(s) {
    let index1 = s.indexOf('(');
    let index2 = s.indexOf(',');
    let index3 = s.indexOf(',', index2+1);
    let index4 = s.indexOf(')');

    let r = parseInt(s.slice(index1+1, index2));
    let g = parseInt(s.slice(index2+2, index3));
    let b = parseInt(s.slice(index3+1, index4));

    return `rgb(${r-25}, ${g-25}, ${b-25})`;
}

function draw(l){
    const drawing = document.createElement('div');
    drawing.classList.add('drawing');
    for(let i=0; i<n; ++i) {
        const div = document.createElement('div');
        div.style.display = 'flex';
        for(let j=0; j<n; ++j) {
            const innerDiv = document.createElement('div');
            innerDiv.style.padding = `${l}px`;
            innerDiv.addEventListener("mouseover", e => {
                if(innerDiv.style.backgroundColor === '') {
                    innerDiv.style.backgroundColor = `rgb(${Math.floor(Math.random()*255)}, ${Math.floor(Math.random()*255)}, ${Math.floor(Math.random()*255)})`
                }else{
                    innerDiv.style.backgroundColor = darken(innerDiv.style.backgroundColor);
                }
            });
            div.appendChild(innerDiv);
        }
        drawing.style.border = '1px solid black';
        drawing.appendChild(div);
    }
    container.appendChild(drawing)
}

draw(l);

document.querySelector("button").addEventListener("click", e => {
    const number = parseInt(document.querySelector('input').value);
    if(isNaN(number) || number < 1 || number > 80) {
        alert("Please enter a number between 1 and 80 inclusive");
        return;
    }
    n = number;
    l = drawingLength/n;
    container.removeChild(document.querySelector('.drawing'));
    draw(l);
})