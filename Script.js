
const game = ()=>
{
	let pScore = 0;
	let cScore = 0;

	const startGame = () =>{

		const playButton = document.querySelector('.intro button');
		const introScreen = document.querySelector('.intro');
		const match = document.querySelector('.match');


		playButton.addEventListener('click', () =>{
			introScreen.classList.add('fadeOut'); 
			match.classList.add('fadeIn');

		});

	};

	const playMatch = () => { 

		const options = document.querySelectorAll('.options button');
		const playerHand =  document.querySelector('.player-hand');
		const computerHand = document.querySelector('.computer-hand');
		const computerOption = ['rock', 'paper' , 'scissors'];
		const hands = document.querySelectorAll('.hands img');
		hands.forEach( hand =>{
			hand.addEventListener('animationend', function(){
					this.style.animation = '';
			});
		});
		//computer option 
		options.forEach( option=>{
			option.addEventListener('click', function() { 

				const computerNumber = Math.floor(Math.random() * 3);
				const computerChoice = computerOption[computerNumber];
				// Call compare hands 
				

				// Change images 

				
				// update score 
				setTimeout(()=>{
					playerHand.src = `${this.textContent}.png`;
					computerHand.src = `${computerChoice}.png`;
					compareHands(this.textContent, computerChoice);
					updateScore();

				}, 2000);



				playerHand.style.animation = 'shakePlayer 2s ease'; 
				computerHand.style.animation = 'shakeComputer 2s ease';
				


			});

		});
		
	};

	const updateScore = () => { 
		const playerScore = document.querySelector('.player-score p');
		const computerScore = document.querySelector('.computer-score p');
		playerScore.textContent = pScore.toString();
		computerScore.textContent = cScore.toString();
		console.log(pScore);

	};

	const compareHands =(playerChoice, computerChoice) => {
		
		const winner = document.querySelector('.winner'); 
		if ( playerChoice === computerChoice){
			winner.textContent = 'Tie';
			return;
		}
		if (playerChoice === 'rock'){

			if( computerChoice === 'scissors')
				{ winner.textContent = 'You won!'
				pScore++;
					return;}
			if ( computerChoice =='paper')
				{ winner.textContent = 'You lose!'
					cScore++;
					return;}

		}
		if (playerChoice === 'paper'){

			if( computerChoice === 'scissors')
				{ winner.textContent = 'You lose!'
					cScore++;
					return;}
			if ( computerChoice =='paper')
				{ winner.textContent = 'You won!'
					pScore++;
					return;}

		}
		if (playerChoice === 'scissors'){

			if( computerChoice === 'rock')
				{ winner.textContent = 'You lose!'
					cScore++;
					return;}
			if ( computerChoice =='paper')
				{ winner.textContent = 'You won!'
					pScore++;
					return;}

		}





	 }; 

	startGame();
	playMatch();
	

};

game();