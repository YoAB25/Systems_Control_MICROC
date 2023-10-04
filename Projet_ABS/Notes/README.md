# Projet Modélisation ABS : Notes

## Modélisation d'un système de freinage sans ABS

### Sous-système 1 : Modèle de freinage
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

### Sous-Système 2 : Modèle de la voiture
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

### Sous-système 3 : Modèle de la roue
Afin d'obtenir des résultats plus cohérentes, nous proposons de grouper tous les 3 sous-systèmes précédement établies. Avant d'entammer cette partie, rappelons d'abord les élements fondamentaux concernant notre système: 
* Tout d'abord, le système prend comme entrée la force de freinage demandée par le conducteur. Cette force est modélisée par une rampe dans un premier temps. Lorsqu'on dépasse la limite d'adhérence, ou encore lorsque la force demandée devient supérieure à $F_{lim} = 1962 N$, on opère alors dans le second cas.
* Dans le deuxième cas, on fonctionne avec le glissement. Ce dernier dépend à la fois de la vitesse des roues ainsi que celui de la voiture. En utilisant la formule magique, ouencore la fonction $f(g)$, on peut obtenir alors la force à appliquer au niveau de chaque roue.
* Cette force sera utilisé pour calculer la vitesse de déplacement de la voiture. En parallèle, en utilisant la force du couple de freinage $Cf = F*R_{roue}$ et le glissement obtenue, on peut calculer la vitesse des roues.
* Les deux vitesses étant obtenues, on peut les utiliser pour boucler le système et calculer la valeur de glissement correspondante. 


### Modèle du système de freinage : Sans ABS
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

### Influence du système de transmission pneumatique
Le système de transmission pneumatique se comporte comme un filtre passe-bas de fonction de transfert $H(s) = \dfrac{1}{0.01s+1}$. 

Dans un premier instant, on peut voir qu'il n'affecte pas le comportement du système. L'allure des deux courbes (vitesse de voiture et des roues) sont identiques à la section précédente. Cependent, si on utilise les outils de mesure, comme montré dans la figure, on peut voir qu'il a introduit un certain temps de retard très minime de $100ms$.
Déjà la nature du filtre passe-bas $H(s) = \dfrac{1}{s+1/\tau}$ où $\tau = 1/0.01 = 100ms$ confome avec ce qui a été obtenu. 

## Modélisation du freinage avec un système ABS
Dans cette partie, on propose d'ajouter un système ABS à notre voiture. La modélisation consiste à contrôler/réguler la consigne de freinage d'entrée (ou encore le freinage demandé). Ainsi, nous proposons d'utiliser un régulateur PID ou PI. Dans notre cas, on a choisi de travailler avec un PI puisque la composente dérivative n'a pas un impact réelle sur notre système.
Pour un rendu optimum, il convient de noter que le glissement a été saturé à la valeur g=0.2. 
Maintenons il faut régler ce PI. Les méthodes empiriques notamment celle de Zeigler-Nichols vu en cours ne fonctionne plus dans notre cas à cause de la variabilité de notre système. L'autre solution consistait à utiliser l'outil d'auto-réglage fourni par Simulink. Cependant, cette dernière n'a pas pu aboutir à cause de la nature non linéaire de notre système. Le seul choix qui reste est alors de suivre la méthode traditionnelle *choisir aléatoirement Kp et Ti*. 
On commence d'abord par des valeurs relativement petites de Ti et Ki, on fait monter Ki jusqu'à avoir une réponse satisfaisante. Après, régler Ti afin d'introduire le terme integrateur du correcteur pour réduire les éventuels dépassements causés par le composante Kp.

Il est important de noter certains remarques __dont on a pas trouvé d'explication encore__: 
* On commence d'abord par le cas initial près de notre résultat précédent
* Lorsqu'on augmente trop le ration Kp/Ti on obtient un arrêt de simulation et un résultat étrange. La vitesse de la voiture devient 0 alors que celle des roues est encore active. *Pour une raison étrange, cela n'a pas pu se reproduire ...*
* Il existe un seul au delà de lequel, peu importe les valeurs Kp et Ti choisi, on n'obtient aucun résultat.
* Mais, ce régulateur a réduit le temps d'arrêt à 3.2s au lieu de +4s sans régulateur !

Après de longues tests, les valeurs ont été choisi en respectant un ratio 1:2 tel que Kp=10 et Ti=5. Encore une fois, ce ne sont pas les paramètres idéaux et celà peut causer des soucis au niveau d'interprétation ultérieurement . 

Autre remarque, le correcteur à temps continu PI(s) où à temps discret donne exactement le même résultat ! *faut investiguer l'utilité de cette question...*
### ABS à temps continu
On utilise le bloc PI(s)
### ABS à temps discret
On utilise le bloc PI(z)
### ABS Tout ou Rien *ToR*
Ici, nous avons inclus un mécanisme pour se rapprocher à la réalité qui consiste à envoyer des accoups de la consigne de freinage à 400N. Cependant, aucune différence n'a pu être repérée par rapport à ce qui précède. *Cela peut revenir au fait que les valeurs de PI ne sont pas convenables...* 
### ABS amélioré
*Réservé à la 3e partie*
## Répartiteur électronique de freinage (EBD)
Dans cette partie, on ne considère plus que le freinage est identique sur les 4 roues. En effet, dans le cas où le moteur est placé vers l'avant du moteur, on aura une certaine répartition de la masse. Cette répartition sera supérieure vers le train avant que le train arrière. Ainsi le train d'avant a tendence à glisser plus puisqu'il va atteindre sa limite d'adhérence en premier.

Notons __d__ la distance entre le centre de gravité et le train avant. Et __D__ la distance entre le train avant et arrière ou l'empattement. La hauteur de centre de gravité sera alors noté h

#### Cas 1 : Répartition de masse avec acc = 0
On applique d'abord le principe fondamentale de la dynamique appliqué à la voiture ! 
$$
\begin{equation}
\sum C = J_{\Delta}.\dfrac{d\Omega_{voiture}}{dt} = 0  \hspace{0.2cm} (La \ voiture \ ne \ tourne \ pas \ quand \ même)
\end{equation}
$$
Sachant qu'on appliquera les couples par rapport au centre d'inertie G
$$
\begin{align*}
     \sum C &= J_{\Delta}.\dfrac{d\Omega_{voiture}}{dt} = 0  \hspace{0.2cm} \\
     N_{av}*d - N_{ar}*(D-d) -T_{av}*h - T_{ar}*h &= 0 
\end{align*}
$$

Or en appliquant le principe fondamentale de la dynamique, on aura:
$$
\begin{align*}
     \sum F_{ext} &= m.\dfrac{dV_{voiture}}{dt} = 0  \hspace{0.2cm} \\
    |x : -T_{ar}-T_{av} &= m*ax = 0 \\
    |y : N_{ar}+N_{av}-mg &= m*ay = 0    
\end{align*}
$$

Alors, en ré-arrangeant la premier équation, et simplifiant les termes qui s'annulent on trouve ce qui suit : 
$$
\begin{align*}
N_{av} &= mg*\dfrac{D-d}{D} \\
N_{ar} &= mg*\dfrac{d}{D}
\end{align*}
$$

#### Cas 2 : Répartition de masse avec acc = 5
Nous aurons les mêmes systèmes d'équation, sauf que cette fois l'accélération va être présente, notamment le terme en T!
$$
\begin{equation}
    -T_{ar}-T_{av} = m*ax = m*a = 5*m
\end{equation}
$$

Alors avec cette modification, on aura : 
$$
\begin{align*}
N_{ar} &= m*\dfrac{gd+ah}{D} \\
N_{av} &= m*\dfrac{g(D-d)-ah}{D}
\end{align*}
$$

Une simple application numérique permet de vérifier que le train arrière ne décollera pas *Vérification que $$N_{ar} > 0$$*
