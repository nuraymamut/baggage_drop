Modulul Sensors_Input
 - am utilizat 2 module pentru implementare: module media_2, module media_4

media_2: 
 - face media a 2 senzori, returnand h_medie ((s1+s2)/2) si h_rest (este 1 daca numarul este impar, 0 daca este par) 
 - h_rest ia valoarea ultimului bit din suma s1 + s2 (ex: sum = 1110, h_rest = sum[0] => h_rest = 0, deci numarul este par, nu are rest)
 - aici se testeaza daca unul dintre senzori este 0, perechea fiind exclusa de la media finala

media_4:
 - calculeaza media celor 2 medii calculate cu media_2 (echivalent cu impartirea la 4 a sumei celor 4 senzori) 
 - se apeleaza media_2 pentru cele 2 perechi (sensor1, sensor3), (sensor2, sensor4) => h1, h1_rest si h2, h2_rest
 - daca h1 & h2 != 0 se verifica: h1_rest si h2_rest, intrucat daca h1_rest = 1 si h2_rest = 1 => trebuie sa le luam in considerare
in media finala (la impartirea cu 2 singurul restul poate sa fie doar 0.5, cand calculam sum = h1 + h2, o sa fie de fapt "h1.5 + h2.5",
care mai adauga un 1 la sum => indiferent daca suma este para sau impara, media finala h = sum/2 + 1, intrucat trebuie sa aproximam 
rezultatul)
 - daca doar h1_rest = 1, trebuie sa verificam daca sum este par sau impar, daca este par nu se ia in considerare devenind la final 
0.25 -> 0 (h = sum/2), daca este impar o sa apara un rest 0.5 de la sum/2 => 0.5 + 0.25 = 0.75 -> 1 (h = sum/2 + 1)
 - daca h1 = 0 => o sa fie exclus de la media finala, verificam daca h2_rest = 0 (daca este => h = h2, daca nu h = h2 + 1)


Modulul Square_Root
 - am utilizat 2 module pentru implementare: module square_root_intreg, module square_root_zecimal

square_root_intreg:
 - foloseste metoda "Digit-by-digit calculation" in format binar, returnand partea intraga (intreg)
 - initial avem intreg = 0000, aux1 = 00_0001 -> il utilizam pentru a lua biti din nr = 0101_0001 (i-am adaugat ultimii 2 biti nr[7] = 0 
si nr[6] = 1), aux2 = 00_0001 -> este format din intreg (primii 4 biti) si b = 01 (ultimii 2 biti)
 - verificam daca aux1 >= aux2, pentru a putea face scadera aux1 - aux2 pe care o atribuim lui aux1 (pe acesta urmeaza sa-l shiftam 
la stanga cu 2 biti pentru a adauga urmatorii biti ai lui nr, nr[5] = 0, nr[4] = 1)
 - daca scadera e posibila o sa-l shiftam pe intreg la stanga cu un bit, si o sa-i adaugam un 1 la final (intreg = 0001)
 - daca nu efectuam scaderea doar o sa-l shiftam pe intreg pentru a adauga un 0 la capat 
 - aux2 o sa fie {intreg, b} in ambele situatii
 - aceste operatii o sa se repete de 4 ori (pana cand ajungem la ultimii 2 biti ai lui nr)  

square_root_zecima:
 - continua algoritmul folosit de square_root_intreg, returnand partea intreaga + partea zecimala
 - se foloseste de interg, aux1, aux2 pentru a continua algoritmul, singurele diferente fiind: 
	1. aux1 nu mai primeste biti de la un numar anume, ci doar i se adauga 2 zerouri la fiecare incrementare a lui i
	2. i = [0:7] deoarece dorim ca partea zecimala sa fie pe 8 biti (neavand constrangerea unui numar, putem sa adaugam cate zerouri
dorim)
 - daca aux1 = 0 => numarul initial de la square_root_intreg este patrat perfect si nu trebuie sa continuam



Modulul Display_And_Drop
 - pentru cele 3 cazuri atribuim valorile necesare pentru mesajele adecvate


Modulul Baggage_Drop
 - apelam modulele sensor_input, square_root, display_and_drop
























