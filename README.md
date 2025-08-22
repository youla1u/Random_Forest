# Prédiction de faillite d’entreprises avec Random Forest

Projet de **Statistique Avancée** réalisé par **YOULA Mohamed (Master 2 IMSD Lorraine)** le 7 mars 2019.  

## 🎯 Objectif
Prédire si une entreprise fera faillite ou non à partir du jeu de données `5year.arff`, en utilisant la méthode des **forêts aléatoires (Random Forest)** sous **R**.  

## 📊 Étapes principales

### 1. Prétraitement des données
- Chargement et nettoyage du dataset (`5910 individus, 64 variables explicatives + 1 variable cible`).  
- Gestion des valeurs manquantes (`?` → `NA`).  
- Réduction du déséquilibre de classes :  
  - Classe 0 (5500 → 610 individus)  
  - Classe 1 (410 individus conservés)  
  - Nouvelles proportions : **60% classe 0 / 40% classe 1**.  
- Conversion des variables explicatives en numériques et mise au format factor pour la variable cible.  

### 2. Modélisation avec Random Forest
- Construction de plusieurs modèles en variant :  
  - **Nombre d’arbres (ntree)** : 500, 5000, 3000.  
  - **Nombre de variables testées par split (mtry)** : 4, 8, 16.  
- Évaluation par l’**erreur OOB (Out of Bag)**.  
- Résultats obtenus :  
  - `model.1 (500 arbres, mtry=8)` → 16,47%  
  - `model.2 (5000 arbres, mtry=8)` → 16,18%  
  - `model.3 (3000 arbres, mtry=16)` → **15,59% (meilleur modèle)**  
  - `model.4 (3000 arbres, mtry=4)` → 16,47%  

### 3. Analyse des variables importantes
- Identification des variables les plus discriminantes :  
  - **V39** : Profit on sales / sales  
  - **V41** : Total liabilities / ((profit on operating activities + depreciation) × (12/365))  
  - **V26** : (Net profit + depreciation) / total liabilities  
- Visualisation par `ggplot2` :  
  - Les variables peu importantes (ex. V40, V45) ne séparent pas les classes.  
  - Les variables importantes (V39, V41) permettent de distinguer clairement les deux classes.  

### 4. Résultats finaux
- Le modèle retenu est **Random Forest (ntree=3000, mtry=16)** avec une **erreur OOB de 15,59%**.  
- Les variables financières liées à la rentabilité et aux dettes sont les plus déterminantes pour prédire la faillite.  

## 🛠️ Technologies
- **R**  
  - `randomForest`  
  - `ggplot2`  

## 📌 Conclusion
Le projet montre que le **Random Forest** est performant pour la prédiction de faillite, après rééquilibrage des classes et optimisation des hyperparamètres.  
