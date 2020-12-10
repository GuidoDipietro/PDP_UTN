# ¡Marte ataca!

**Nos equivocamos. El coronavirus no vino de China ni de Estados Unidos: vino de los aliens. Un grupo de extraterrestres particularmente belicoso quiere tomar la Tierra y todos los otros planetas habitables, y para eso está infectándolos de distintas enfermedades. Para saber si les está yendo bien o no, están desarrollando un sistema en Haskell, y para eso, a punta de pistola láser con mucha diplomacia, nos obligaron a implementar ciertas funcionalidades en este curso.**

![](marte.jpg)

De aquellas enfermedades que los alienígenas están probando se conoce su porcentaje de mortalidad y la medida principal que la combate
```haskell
coronaVirus = Enfermedad 3.5 "cuarentena"
```

De cada planeta se conoce una lista de continentes, su población total y las medidas que se están tomando en un determinado momento:

```haskell
tierraAntesDeCuarentena = Planeta 7777382699 ["América", "Asia", "Africa", "Europa", "Oceanía"] ["lavarse las manos"]
```
Definir los tipos de datos necesarios, inventando al menos 3 enfermedades y 3 planetas.
1. Combinar dos enfermedades: dadas dos enfermedades, obtiene una nueva enfermedad con la suma de las tasas de mortalidad, y donde la medida de protección que se necesita es la de la primera enfermedad.
2. Tomar medidas de protección en un planeta: dado un planeta y una enfermedad, hacer que ese planeta tome las medidas necesarias para que una enfermedad no lo afecte. ¡Ojo! No se puede implementar 2 veces la misma medida en un mismo planeta, o sea que si la medida ya se estaba implementando, no es necesario volverla a implementar.
3. Saber si un planeta está en el horno ante una enfermedad, lo que sucede si no está tomando aquella medida necesaria para combatirla y además esa enfermedad puede matar más de 1000000 personas.
4. Saber si un planeta tiene más medidas de prevención que habitantes por continente. Si no hay información sobre los continentes, se asume que hay un único continente que ocupa todo el planeta..
5. Averiguar los que sucede cuando que una enfermedad ataca a un planeta, informando cómo queda el planeta y la cantidad de víctimas.
   - si está protegido contra esa enfermedad no debe pasar nada, el planeta queda tal cual y las víctimas son 0
   - si no está protegido, la cantidad de víctimas es proporcional a la tasa de mortalidad de la enfermedad y la población bajará en dicha magnitud. Luego, el planeta toma las medidas necesarias de protección.
6. Dadas dos enfermedades y un planeta, averiguar si la primera combinada con la segunda provocaría más víctimas al atacarlo que la segunda combinada con la primera.

