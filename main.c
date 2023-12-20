/*
Author: Jacob Anderson
RedID: 827419418
Description: Navigate the correct path following the rules given.
Status: I am using three if else statements to control the levels because my while loop wasn't working. 
		It was causing an issue with the timer not adjusting properly(see rev 4). That is why my line 
		count is so high. I have changed the for loops to while loops and got the code working again 
		as it did before. I would still like to try to randomize the array path if possible. I have added 
		an incentive to the user to keep playing by putting in a scoring system based on how quick they 
		finish the maze. It is just adding up the remaining time from each level. Currently, my timer 
		variable is just a placeholder that only loses time if the wrong path gets selected. There is no 
		backtracking down the path you came as you'll lose time. I added a break function to where if the
		timer runs out at any point, the game ends and you get a game over screen and your score. Otherwise
		if you complete all three levels, you get printed a congratulations screen with your score.

For MIPS:
Recode for loops to while loops - DONE
Make Arrays access pointers instead of using square brackets
Make while loops act as if statements

*/

#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>

void  main(void) {
	
	//GLOBAL VARIABLES
	srand(time(NULL));
	char cMove;
	int row = 10, col = 3, level = 0, finalScore = 0, timer = 60, i = 0, j = 0;
	int yPos, xPos, randNum, fillNum, key;

	//GAME CODE START
	while (level < 4) {
		if (timer == 0) {
			break;
		}
		timer = 60;
		level++;
		if (level == 1) {
			key = 3;
			int iBoard[10][3] = { { 0, 0, 1 },
								  { 0, 1, 1 },
								  { 1, 1, 0 },
								  { 1, 0, 0 },
								  { 1, 1, 1 },
								  { 0, 0, 1 },
								  { 1, 1, 1 },
								  { 1, 0, 0 },
								  { 1, 1, 0 },
								  { 0, 1, 0 } };

			printf("Level: %d - Evenly divide by 3		Time: %d\n", level, timer);
			/*
			Changing the array declared above to use randomly generated numbers between 10 and 99
			and then printing the changed array.
			*/
			while (i < row) {
				j = 0;
				while (j < col) {
					if (iBoard[i][j] != 0) {
						randNum = (rand() % (99 - 10 + 1)) + 10;
						while (randNum % key != 0) {
							randNum = (rand() % (99 - 10 + 1)) + 10;
						}
						iBoard[i][j] = randNum;
					}
					else {
						fillNum = (rand() % (99 - 10 + 1)) + 10;
						while (fillNum % key == 0 && fillNum != 88) {
							fillNum = (rand() % (99 - 10 + 1)) + 10;
						}
						iBoard[i][j] = fillNum;
					}
					printf("[%-2d] ", iBoard[i][j]);
					j++;
				}
				printf("\n");
				i++;
			}
			//Deciding where the user starts on the board
			printf("Where would you like to start? Enter A for left, W for middle, or D for right.");
			scanf(" %c", &cMove);

			if (cMove == 'A' || cMove == 'a') {
				yPos = 9, xPos = 0;
				iBoard[yPos][xPos] = 'X';
			}
			else if (cMove == 'W' || cMove == 'w') {
				yPos = 9, xPos = 1;
				iBoard[yPos][xPos] = 'X';
			}
			else if (cMove == 'D' || cMove == 'd') {
				yPos = 9, xPos = 2;
				iBoard[yPos][xPos] = 'X';
			}

			system("cls");
			printf("Level: %d - Evenly divide by 3		Time: %d\n", level, timer);
			i = 0;
			while (i < row) {
				j = 0;
				while (j < col) {
					if (iBoard[i][j] != 'X') {
						printf("[%-2d] ", iBoard[i][j]);
					}
					else {
						printf("[X ] ");
					}
					j++;
				}
				printf("\n");
				i++;
			}

			/*
			Moving the character across the board and will remove time if moved into an index
			where it doesn't match the key.
			*/
			while (yPos > 0 && timer > 0) {
				printf("Which way would you like to move? Press W for up, A for left, or D for right. You can't move down or backwards.");
				scanf_s(" %c", &cMove);

				if (cMove == 'W' || cMove == 'w') {
					if (yPos < 10) {
						yPos = yPos - 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				else if (cMove == 'A' || cMove == 'a') {
					if (xPos > 0) {
						xPos = xPos - 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
					else {
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				else if (cMove == 'D' || cMove == 'd') {
					if (xPos < 2) {
						xPos = xPos + 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
					else {
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				//Reprints the board with X as the player.
				printf("Level: %d - Evenly divide by 3		Time: %d\n", level, timer);
				i = 0;
				while (i < row) {
					j = 0;
					while (j < col) {
						if (iBoard[i][j] != 'X') {
							printf("[%-2d] ", iBoard[i][j]);
						}
						else {
							printf("[%c ] ", 88);
						}
						j++;
					}
					printf("\n");
					i++;
				}
			}
			//ENDING CODE AFTER EACH LOOP BEFORE LEVEL CHANGE
			finalScore = finalScore + timer;
			system("cls");
		}
   else if (level == 2) {
			key = 7;
			int iBoard[10][3] = { { 1, 0, 0 },
								  { 1, 1, 1 },
								  { 0, 0, 1 },
								  { 0, 0, 1 },
								  { 0, 1, 1 },
								  { 1, 1, 0 },
								  { 1, 0, 0 },
								  { 1, 0, 0 },
								  { 1, 1, 1 },
								  { 0, 0, 1 } };

			printf("Level: %d - Evenly divide by 7		Time: %d\n", level, timer);
			/*
			Changing the array declared above to use randomly generated numbers between 10 and 99
			and then printing the changed array.
			*/
			i = 0;
			while (i < row) {
				j = 0;
				while (j < col) {
					if (iBoard[i][j] != 0) {
						randNum = (rand() % (99 - 10 + 1)) + 10;
						while (randNum % key != 0) {
							randNum = (rand() % (99 - 10 + 1)) + 10;
						}
						iBoard[i][j] = randNum;
					}
					else {
						fillNum = (rand() % (99 - 10 + 1)) + 10;
						while (fillNum % key == 0 && fillNum != 88) {
							fillNum = (rand() % (99 - 10 + 1)) + 10;
						}
						iBoard[i][j] = fillNum;
					}
					printf("[%-2d] ", iBoard[i][j]);
					j++;
				}
				printf("\n");
				i++;
			}
			//Deciding where the user starts on the board
			printf("Where would you like to start? Enter A for left, W for middle, or D for right.");
			scanf(" %c", &cMove);

			if (cMove == 'A' || cMove == 'a') {
				yPos = 9, xPos = 0;
				iBoard[yPos][xPos] = 'X';
			}
			else if (cMove == 'W' || cMove == 'w') {
				yPos = 9, xPos = 1;
				iBoard[yPos][xPos] = 'X';
			}
			else if (cMove == 'D' || cMove == 'd') {
				yPos = 9, xPos = 2;
				iBoard[yPos][xPos] = 'X';
			}

			system("cls");
			printf("Level: %d - Evenly divide by 7		Time: %d\n", level, timer);
			i = 0;
			while (i < row) {
				j = 0;
				while (j < col) {
					if (iBoard[i][j] != 'X') {
						printf("[%-2d] ", iBoard[i][j]);
					}
					else {
						printf("[X ] ");
					}
					j++;
				}
				printf("\n");
				i++;
			}

			/*
			Moving the character across the board and will remove time if moved into an index
			where it doesn't match the key.
			*/
			while (yPos > 0 && timer > 0) {
				printf("Which way would you like to move? Press W for up, A for left, or D for right. You can't move down or backwards.");
				scanf_s(" %c", &cMove);

				if (cMove == 'W' || cMove == 'w') {
					if (yPos < 10) {
						yPos = yPos - 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				else if (cMove == 'A' || cMove == 'a') {
					if (xPos > 0) {
						xPos = xPos - 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
					else {
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				else if (cMove == 'D' || cMove == 'd') {
					if (xPos < 2) {
						xPos = xPos + 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
					else {
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				//Reprints the board with X as the player.
				printf("Level: %d - Evenly divide by 7		Time: %d\n", level, timer);
				i = 0;
				while (i < row) {
					j = 0;
					while (j < col) {
						if (iBoard[i][j] != 'X') {
							printf("[%-2d] ", iBoard[i][j]);
						}
						else {
							printf("[%c ] ", 88);
						}
						j++;
					}
					printf("\n");
					i++;
				}
			}
			//ENDING CODE AFTER EACH LOOP BEFORE LEVEL CHANGE
			finalScore = finalScore + timer;
			system("cls");
		} 
   else if (level == 3) {
			key = 13;
			int iBoard[10][3] = { { 1, 1, 0 },
								  { 1, 0, 0 },
								  { 1, 1, 1 },
								  { 0, 0, 1 },
								  { 0, 1, 1 },
								  { 1, 1, 0 },
								  { 1, 0, 0 },
								  { 1, 1, 1 },
								  { 0, 0, 1 },
								  { 0, 1, 1 } };

			printf("Level: %d - Evenly divide by 13		Time: %d\n", level, timer);
			/*
			Changing the array declared above to use randomly generated numbers between 10 and 99
			and then printing the changed array.
			*/
			i = 0;
			while (i < row) {
				j = 0;
				while (j < col) {
					if (iBoard[i][j] != 0) {
						randNum = (rand() % (99 - 10 + 1)) + 10;
						while (randNum % key != 0) {
							randNum = (rand() % (99 - 10 + 1)) + 10;
						}
						iBoard[i][j] = randNum;
					}
					else {
						fillNum = (rand() % (99 - 10 + 1)) + 10;
						while (fillNum % key == 0 && fillNum != 88) {
							fillNum = (rand() % (99 - 10 + 1)) + 10;
						}
						iBoard[i][j] = fillNum;
					}
					printf("[%-2d] ", iBoard[i][j]);
					j++;
				}
				printf("\n");
				i++;
			}
			//Deciding where the user starts on the board
			printf("Where would you like to start? Enter A for left, W for middle, or D for right.");
			scanf(" %c", &cMove);

			if (cMove == 'A' || cMove == 'a') {
				yPos = 9, xPos = 0;
				iBoard[yPos][xPos] = 'X';
			}
			else if (cMove == 'W' || cMove == 'w') {
				yPos = 9, xPos = 1;
				iBoard[yPos][xPos] = 'X';
			}
			else if (cMove == 'D' || cMove == 'd') {
				yPos = 9, xPos = 2;
				iBoard[yPos][xPos] = 'X';
			}

			system("cls");
			printf("Level: %d - Evenly divide by 13		Time: %d\n", level, timer);
			i = 0;
			while (i < row) {
				j = 0;
				while (j < col) {
					if (iBoard[i][j] != 'X') {
						printf("[%-2d] ", iBoard[i][j]);
					}
					else {
						printf("[X ] ");
					}
					j++;
				}
				printf("\n");
				i++;
			}

			/*
			Moving the character across the board and will remove time if moved into an index
			where it doesn't match the key.
			*/
			while (yPos > 0 && timer > 0) {
				printf("Which way would you like to move? Press W for up, A for left, or D for right. You can't move down or backwards.");
				scanf_s(" %c", &cMove);

				if (cMove == 'W' || cMove == 'w') {
					if (yPos < 10) {
						yPos = yPos - 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				else if (cMove == 'A' || cMove == 'a') {
					if (xPos > 0) {
						xPos = xPos - 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
					else {
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				else if (cMove == 'D' || cMove == 'd') {
					if (xPos < 2) {
						xPos = xPos + 1;
						if (iBoard[yPos][xPos] % key != 0) {
							timer = timer - 10;
							system("cls");
						}
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
					else {
						iBoard[yPos][xPos] = 'X';
						system("cls");
					}
				}
				//Reprints the board with X as the player.
				printf("Level: %d - Evenly divide by 13		Time: %d\n", level, timer);
				i = 0;
				while (i < row) {
					j = 0;
					while (j < col) {
						if (iBoard[i][j] != 'X') {
							printf("[%-2d] ", iBoard[i][j]);
						}
						else {
							printf("[%c ] ", 88);
						}
						j++;
					}
					printf("\n");
					i++;
				}
			}
			//ENDING CODE AFTER EACH LOOP BEFORE LEVEL CHANGE
			finalScore = finalScore + timer;
			system("cls");
		}
	}

	//ENDING PRINTOUT
	if (timer == 0) {
		printf("GAME OVER! You ran out of time! Better luck next time!\n");
	}
	else {
		printf("Congratulations! You won! Your final score is: %d!\n", finalScore);
	}
}