[![version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/ibarram/ReconocimientoPatrones/)
[![GitHub commit activity (branch)](https://img.shields.io/github/commit-activity/w/ibarram/ReconocimientoPatrones)](https://github.com/ibarram/ReconocimientoPatrones/)
[![GitHub discussions](https://img.shields.io/github/discussions/ibarram/ReconocimientoPatrones)](https://github.com/ibarram/ReconocimientoPatrones/discussions)
[![GitHub issues](https://img.shields.io/github/issues/ibarram/ReconocimientoPatrones)](https://github.com/ibarram/ReconocimientoPatrones/issues)
![Gitter](https://img.shields.io/gitter/room/ibarram/ReconocimientoPatrones)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

<br />
<div align="center">
  <a href="https://github.com/ibarram/ReconocimientoPatrones">
    <img src="/doc/img/escudo-png.png" alt="Logo" width="120" height="120">
  </a>

  <h3 align="center">Reconocimiento de Patrones (MIE.VR01.09)</h3>

  <p align="center">
    Material del curso: temario, presentaciones, prácticas, código y proyecto final
    <br />
    Implementación en <b>R</b> (RStudio, tidyverse, tidymodels, Quarto)
    <br />
    <a href="https://github.com/ibarram/ReconocimientoPatrones"><strong>Explorar la documentación »</strong></a>
    <br />
    <br />
    <a href="https://github.com/ibarram/ReconocimientoPatrones">Ver Demo</a>
    ·
    <a href="https://github.com/ibarram/ReconocimientoPatrones/issues">Reportar Bug</a>
    ·
    <a href="https://github.com/ibarram/ReconocimientoPatrones/issues">Requiere Modificaciones</a>
  </p>
</div>

<details><summary>Table of Contents</summary><p>
 
 * [Introducción](#Introducción)
 * [Contenido](#Contenido)
 * [Competencia de la Unidad de Aprendizaje](#Competencia-de-la-Unidad-de-Aprendizaje)
 * [Evaluación](#Evaluación)
 * [Presentaciones](#Presentaciones)
 * [Prácticas y Proyecto Final](#Prácticas-y-Proyecto-Final)
 * [Listado de Códigos Desarrollados durante la UDA](#listado-de-códigos-desarrollados-durante-la-uda)
 * [Contacto](#Contacto)
 * [Bibliografía](#Bibliografía)
 * [Licencia](https://github.com/ibarram/ReconocimientoPatrones/blob/main/LICENSE)

</p></details><p></p>

## Introducción

### Competencia de la UDA (resumen)

Diseña, implementa y evalúa sistemas de reconocimiento de patrones mediante el pipeline completo (datos → preprocesamiento → representación/rasgos → modelo → validación → métricas), utilizando fundamentos estadísticos y de aprendizaje automático. Desarrolla soluciones reproducibles en **R** para problemas de clasificación, regresión y agrupamiento, interpretando resultados con pensamiento crítico, considerando riesgos experimentales (p. ej., *data leakage*), desbalance de clases y criterios de desempeño acordes al dominio de aplicación.

### Contribución de la UDA al Perfil de Egreso (sugerida)

Esta Unidad de Aprendizaje incide de manera directa en la formación de la siguiente competencia:

CE. Diseña y valida modelos de reconocimiento de patrones y aprendizaje automático para resolver problemas de ingeniería y ciencia de datos, con enfoque reproducible y comunicación científica.

### Contextualización

UDA dirigida a estudiantes de la **Maestría en Ingeniería Eléctrica (Instrumentación y Sistemas Digitales)**, con duración total de **12 semanas** a **4.5 h/semana** (≈ 45 horas).
El curso enfatiza el diseño experimental correcto (particiones, *cross-validation*, tuning) y el desarrollo reproducible en R.

---

## Contenido

El [contenido](doc/pdf/Temario.pdf) de la Unidad de Aprendizaje es el siguiente:

1. **Introducción al reconocimiento de patrones y flujo de trabajo en R**
	* Definiciones: patrón, clase, etiqueta, característica, variabilidad y ruido
	* Pipeline completo y reproducibilidad
	* Diseño experimental: train/valid/test, CV y prevención de *data leakage*
2. **Fundamentos probabilísticos y decisión estadística**
	* Bayes, riesgo, costos, modelos generativos vs discriminativos
3. **Preparación de datos y representación de patrones**
	* Limpieza, escalado, codificación, valores faltantes
	* Ingeniería/selección de características
	* Reducción de dimensionalidad (PCA; panorama t-SNE/UMAP)
4. **Clasificación supervisada clásica**
	* kNN, regresión logística, LDA/QDA, SVM (kernels)
	* Calibración y selección de umbral
5. **Ensembles y métodos basados en árboles**
	* Árboles, Random Forest, Boosting (panorama)
	* Desbalance de clases y métricas adecuadas
	* Interpretabilidad (panorama: permutation importance, PDP/ICE, SHAP)
6. **Aprendizaje no supervisado y evaluación integral**
	* Clustering (k-means, jerárquico; panorama GMM)
	* Validación no supervisada (silhouette, Davies–Bouldin)
	* Integración del pipeline y reporte reproducible

---

## Competencia de la Unidad de Aprendizaje

Diseña, implementa y evalúa sistemas de reconocimiento de patrones mediante el pipeline completo (datos → preprocesamiento → representación/rasgos → modelo → validación → métricas), utilizando fundamentos estadísticos y de aprendizaje automático en **R**. Interpreta resultados con pensamiento crítico, considerando limitaciones experimentales, desbalance de clases y criterios de desempeño acordes al dominio. Comunica hallazgos de forma clara y reproducible.

---

## Evaluación

La evaluación de la Unidad de Aprendizaje será desarrollada de acuerdo a la siguiente tabla:

|Número|Elemento|Porcentaje|
|---|---|---|
|1|Práctica 1: EDA + diseño experimental (Quarto)|15%|
|2|Práctica 2: Baselines + métricas (clasificación/regresión)|15%|
|3|Evaluación 1: Bayes + validación|15%|
|4|Práctica 3: Features + PCA + selección (pipeline reproducible)|15%|
|5|Evaluación 2: Modelos supervisados (kNN, LR, LDA/QDA, SVM)|15%|
|6|Proyecto final (código + reporte reproducible)|15%|
|7|Presentación del proyecto (defensa y crítica)|10%|

### Rúbrica sugerida para prácticas/proyecto (6 ejes)

|Número|Medida|Ponderación|Criterio|
|---|---|---|---|
|1|Desempeño|16.7%|Métricas adecuadas al problema (p. ej., F1/balanced accuracy/ROC-PR AUC; RMSE/MAE) y reportadas con resampling|
|2|Diseño experimental|16.7%|Uso correcto de train/valid/test, CV, tuning y prevención de *data leakage*|
|3|Reproducibilidad|16.7%|Semillas, proyecto estructurado, reporte ejecutable (Quarto), trazabilidad (sessionInfo)|
|4|Código fuente|16.7%|Legible, modular, con funciones, estructura y buenas prácticas|
|5|Análisis crítico|16.6%|Interpretación, limitaciones, sesgos, desbalance, decisiones justificadas|
|6|Comunicación técnica|16.6%|Figuras/tablas claras, conclusiones y recomendaciones accionables|

Elementos mínimos de los reportes:
1. **Introducción**
	* **Fundamentación de la tarea, práctica o proyecto**
2. **Objetivos**
	* **Objetivo general y específicos**
3. **Procedimiento (pipeline)**
	* **Descripción de datos y preprocesamiento**
	* **Modelo(s), validación, tuning (si aplica)**
	* **Prevención de fuga de información**
4. **Resultados y análisis**
	* **Tablas/figuras con explicación**
	* **Análisis de desempeño y robustez**
5. **Tabla comparativa**
	* **Comparación de modelos/variantes**
6. **Conclusiones**
	* **Conclusiones técnicas y personales**
7. **Bibliografía**
	* **Formato APA o IEEE**

---

## Presentaciones

Las presentaciones de la Unidad de Aprendizaje estarán disponibles para su descarga.

|Archivo|Descripción|Enlace|
|---|---|---|
|0_Presentacion.pdf|Presentación de la Unidad de Aprendizaje|[Download](/doc/slide/0_Presentacion.pdf)|
|1_Intro_R.pptx|Introducción a R (estudiantes sin experiencia)|[Download](/doc/slide/1_Intro_R.pdf)|
|2_Pipeline.pdf|Pipeline de RP y diseño experimental|[Download](/doc/slide/2_Pipeline.pdf)|
|3_Bayes.pdf|Fundamentos Bayesianos y decisión estadística|[Download](/doc/slide/3_Bayes.pdf)|
|4_Features_PCA.pdf|Features, selección y PCA|[Download](/doc/slide/4_Features_PCA.pdf)|
|5_Clasificacion.pdf|kNN, LR, LDA/QDA, SVM|[Download](/doc/slide/5_Clasificacion.pdf)|
|6_Ensembles.pdf|Árboles, RF, Boosting, interpretabilidad|[Download](/doc/slide/6_Ensembles.pdf)|
|7_Clustering.pdf|Clustering y validación no supervisada|[Download](/doc/slide/7_Clustering.pdf)|

---

## Prácticas y Proyecto Final

* **Prácticas**: notebooks y reportes en Quarto con datasets provistos o de dominio del estudiante.
* **Proyecto final**: pipeline completo reproducible (datos → features → modelo → validación → métricas → discusión).

Entrega sugerida:
* `/reports/` (QMD + HTML/PDF)
* `/R/` (funciones)
* `/data/` (raw/processed con README de origen)

---

## Listado de Códigos Desarrollados durante la UDA

A lo largo de esta UDA, se implementan y documentan ejemplos prácticos en R:

* Importación/limpieza y EDA (`tidyverse`).
* Particionado y resampling (`rsample`).
* Preprocesamiento reproducible (`recipes`).
* Modelos: kNN, LR, LDA/QDA, SVM, árboles, Random Forest (`parsnip`).
* Métricas, ROC/PR y matrices de confusión (`yardstick`).
* Reportes reproducibles (Quarto).

El listado completo de códigos y su explicación se encuentra en:

[Consulta el listado completo de códigos aquí](doc/markdown/Codigo.md).

---

## Contacto

[Dr. M.-A. Ibarra-Manzano](mailto:ibarram@ugto.mx?subject=[GitHub]%20ReconocimientoPatrones) - [DICIS-UG](http://www.posgrados.ugto.mx/Profesores/Perfil.aspx?id=20150) - [ORCID: 0000-0003-4317-0248](https://orcid.org/0000-0003-4317-0248) - [SCOPUS: 15837259000](https://www.scopus.com/authid/detail.uri?authorId=15837259000)

Unidad de Aprendizaje Link: [ReconocimientoPatrones](https://github.com/ibarram/ReconocimientoPatrones/)

---

## Bibliografía

- Duda, R. O., Hart, P. E., & Stork, D. G. (2001). *Pattern Classification* (2nd ed.). Wiley.
- Bishop, C. M. (2006). *Pattern Recognition and Machine Learning*. Springer.
- Hastie, T., Tibshirani, R., & Friedman, J. (2009). *The Elements of Statistical Learning* (2nd ed.). Springer.
- James, G., Witten, D., Hastie, T., & Tibshirani, R. (2021). *An Introduction to Statistical Learning* (2nd ed.). Springer.
- Wickham, H., & Grolemund, G. (2017). *R for Data Science*. O’Reilly.
- Kuhn, M., & Silge, J. (2022). *Tidy Modeling with R*. O’Reilly.
- Artículos selectos recientes de reconocimiento de patrones y aprendizaje automático aplicados al dominio del curso.
