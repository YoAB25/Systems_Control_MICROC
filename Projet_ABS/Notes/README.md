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
