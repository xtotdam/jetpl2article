JETPL2article
=============

Класс, мимикрирующий под стандартный класс журнала *Письма в ЖЭТФ*, но позволяющий вставлять изображения.
Наследуется от `article`.
Заодно сделан и стилевой файл для bibTeX'а.

Файлы в папке `example/` взяты с http://www.jetpletters.ac.ru/ru/rus-ex.shtml

### Опции

* `onlynames`       - печатает путь к изображению вместо его самого
* `smallerfigures`  - делает изображения чуть меньше
* `colormissing`    - расцвечивает отсутствующие \cite и \ref, используя пакет `fixme`


#### Определенные команды

`\insertfigure{путь}` - вставляет изображение


##### Пример

Пример годится как для `jetpl.cls`, так и для `jetpl2article.cls`.

```latex
\documentclass{jetpl2article}
% ИЛИ
% \documentclass{jetpl}

\providecommand{\insertfigure}[1]{\fbox{#1}}
```

```latex
\begin{figure}
\centering
\insertfigure{path-to-pdf.pdf}
\caption{Подпись}
\label{fig1}
\end{figure}
```
