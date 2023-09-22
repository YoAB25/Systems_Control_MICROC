# Projet Modélisation ABS : Notes

## Modélisation d'un système de freinage sans ABS

## Sous-système 1 : Modèle de freinage
Dans cette partie, nous nous sommes intéressés à la modélisation du premier bloc de notre système. Le modèle de freinage.

Tant que la force demandée (ou appliquée au niveau de la pédale par le conducteur) est inférieur à un seuil donnée, la force demandée *F_demandée* sera égale à la force appliquée au niveau des roues *F_appliquée*.

Cette condition a été établie grâce à la donnée de la limite d'adhérence, à savoir *f=0.8* au-delà de laquelle nous nous placerons dans le cas suivant.

__Cas limite :__                                              
$$
F_{lim} = f*\frac{mg}{4} = (1/4) * 0.8 * 1000 * 9.81 = 1962 
$$

Dans le cas où F_demandée est supérieur que la limite F_lim, on donne la relation suivant où le glissement dépendera du coefficient de friction où encore des vitesses de la roue, et de la voiture:

$$
F_{appliquée} = f(g) * \frac{m * g}{4}  
$$
où
$$
g = 1 - \frac{V_{roue}}{V_{voiture}}
$$

Les schémas obtenues dans le dossier image concernant cette partie peuvent être interprétées ainsi : 

* La fonction f(g) est continue, dérivable sur le domaine [0,+\inf[. Cette dernière croît sur l'intervalle [0,0.2] et décroît sur le reste du domaine de définition (g=0.2 correspond à un coeff de friction extrêmum).
* Le coefficient de friction f est proportionnel à la force de freinage appliquée à un facteur près '''K = 0.25*mg''' 
* Lors des faibles valeurs de glissement (g->0), on a un facteur d'adhérence proche de sa valeur maximale. En ajoutant l'information de la proportionnalité, on déduit que la force appliquée dans cette intervalle sera supérieur au seuil de la condition (F = 1962 N)
* Lors des grandes valeurs de glissement (g->1) sachant que f tend vers 0.6 à l'infini, on va avoir une force appliquée inférieur au seuil.
* Ses résultats sont conformes à ce qui a été obtenues au graphes *(voir section images)*.

Il faut aussi rappeler que le glissement *g* dépend à la fois de la vitesse de la voiture et la vitesse de la roue.
Alors, on peut *à priori* donner ces *pré*-interprétations:
* Pour g->0 c.à.d Vroue=Vvitesse, on aura un freinage avec une force importante.
* Pour g->1(ou->\inf), alors on a deux possibilités:
    * Soit Vvoiture->\inf ce qui sera physiquement impossible;
    * Soit Vroue->0. Et alors on obtient une décroissant de la force appliquée par rapport au seuil.

## Sous-Système 2 : Modèle de la voiture
Dans cette partie, nous souhaitons modéliser la voiture. Nous avons considéré que les forces de freinage sont réparties au niveau de chaque roue. 
En appliquant le principe fondamentale de la dynamique:
$$
    M.\frac{dV_{voiture}}{dt} = -4 * F
$$
Alors
$$
    V_{voiture} = -\frac{4 * F}{m} + V_0
$$

D'après les résultats d'application d'une rampe de freinage et en ajustant les valeurs de glissement, nous avons déduit les résultats suivants : 

* Cas *Extremum* 1 : g = 0 -> La vitesse décroît jusqu'à atteindre une valeur constant à l'infinie (à partir de l'instant où on dépasse la valeur limite d'adhérence et la force demandée __Fd>1962__). C'est pas un cas vraiment qu'on veut car la voiture ne va plus freiner.

    --> Il faut noter que $$g = 1- \frac{V_{roue}}{V_{voiture}}$$ 
    Alors on va avoir la vitesse de roue égale à la vitesse de la voiture !!!

* Cas *Extremum* 2 : g = 1 -> La vitesse décroît à 0 (une fois la condition de bascule est vérifiée) mais après un certain temps relativement important :

    (Pour une valeur de rampe *"300"* on va avoir 18s de temps d'arrêt)

* Cas *Optimal* 3 : g = 0.2 -> alors on aura un coefficient de friction *f=0.95* extremum. Par conséquent, cela correspond à la valeur maximale de force de freinage qu'on peut avoir (*Cela est dû à la proportionnalité entre __f__ et __Fappliquée__ *).
Quant à la vitesse, et pour la même consigne de rampe appliquée, nous avons eu un bon temps d'arrêt comparé avec ce qui précède *(bon, il est légèrement inférieur à cause de la consigne IdK)*. Le temps d'arrêt est évalué à *t=14s*, soit alors 4s de différence.

* Cas *Test_Aléa* 4 : g=0.5 g __\in__ [0.2, 1] -> On s'approche du cas g=1 avec un temps moins réduit t=16.5s

* Cas *Test_Aléa* 5 : g = 0.1 __\in__ [0, 0.2] -> Même observation

__Remarque__ : 
* Il faut noter que le glissement dépend des deux vitesses (voiture, roue). Cependant, pour des fins de test, nous avons considérer que le glissement est constant. Le comportement étudié et tenu en compte sera lors de la combinaison des différentes blocs.
* Dans certains cas (où la vitesse décroît vers 0 au bout d'une durée t donnée), nous avons obtenus des valeurs de vitesses négatives ce qui est physiquement impossible (au moins à l'échelle instantanné). Pour cela un bloc comparateur prend le maximum entre la valeur de la vitesse de sortie et 0 pour faire afficher un graphe adéquat. 
* Encore une fois, les graphes du cas par cas sont disponible dans le dossier *image*.

## Sous-système 3 : Modèle de la roue
Afin d'obtenir des résultats plus cohérentes, nous proposons de grouper tous les 3 sous-systèmes précédement établies. Avant d'entammer cette partie, rappelons d'abord les élements fondamentaux concernant notre système: 
* Tout d'abord, le système prend comme entrée la force de freinage demandée par le conducteur. Cette force est modélisée par une rampe dans un premier temps. Lorsqu'on dépasse la limite d'adhérence, ou encore lorsque la force demandée devient supérieure à $F_{lim} = 1962 N$, on opère alors dans le second cas.
* Dans le deuxième cas, on fonctionne avec le glissement. Ce dernier dépend à la fois de la vitesse des roues ainsi que celui de la voiture. En utilisant la formule magique, ouencore la fonction $f(g)$, on peut obtenir alors la force à appliquer au niveau de chaque roue.
* Cette force sera utilisé pour calculer la vitesse de déplacement de la voiture. En parallèle, en utilisant la force du couple de freinage $Cf = F*R_{roue}$ et le glissement obtenue, on peut calculer la vitesse des roues.
* Les deux vitesses étant obtenues, on peut les utiliser pour boucler le système et calculer la valeur de glissement correspondante. 


## Modèle du système de freinage : Sans ABS
Dans cette partie, nous proposons de grouper les 3 différents sous-systèmes précédemment détaillés. Rappelons que notre but est la simulation d'un système de freinage sans ABS.

A l'instar de ce qui précède, les résultats obtenues et utilisées pour notre interprétation sont disponibles dans le dossier *images* présents dans ce même *repository*.

* __Résultat 1 : La force appliquée au niveau des roues :__ \
Commençant d'abord par la visualisation de la force appliquée au niveau des roues. Cette force qui a une allure assez particulière. Remarquons que la force appliquée au départ est égale à celle demandée par le conductucteur (ou alors la consigne de rampe de force). Cependant après 2s, on assiste à une chute brusque pour remonter un certaine valeur à l'infini. Ce résultat est, en quelque sorte, similaire à ce qu'on avait eu pour le cas de $g=0$. Sauf que, cette fois, on peut retrouver l'allure de la fonction magique après 2s. C'est au bout de cette courte période qu'on a $F_{demandée}>F_{lim}=1962N$. 
* __Résultat 2 : Allure du glissement:__ \
A $t=0$, la vitesse de déplacement de la roue est égale à celle des roues. Alors, par la construction de g, on aura une valeur nulle au voisinage de $t=0$. A partir de $t=2s$, encore une fois c'est le temps nécessaire pour dépasser la limite de force, le glissement croît jusqu'à atteindre sa valeur limite en 1.
* __Résulatt 3 : Allure des deux vitesses:__\
Le graphe obtenu était également conforme avec ce qui a été attendu. A $t=0$, les deux vitesses sont identiques, au moment ou le glissement entre en jeu (à partir de $t=2s$), on assiste à une différence significative des deux vitesses. Cette dernière se manifeste clairement après un certain temps, le temps d'arrêt. A un certain moment donné, lorsque la vitesse de la roue tend vers 0, on remaque que celle de la voiture est encore opérationnelle. Celà est dû au fait qu'on opère avec un glissement tel \
que $g \in [0.2,1[ \subset [0,1]$. 

__Conclusion : Cohérence des résultats.__