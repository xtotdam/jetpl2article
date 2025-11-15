JETPL2article
=============

Класс, мимикрирующий под стандартный класс журнала *Письма в ЖЭТФ*, но позволяющий вставлять изображения.
Наследуется от `article`.
Заодно сделан и стилевой файл для bibTeX'а.
Бонусом может подсвечивать отсутствующие \ref и \cite.
Возможна сборка как pdfLaTeX, так и LuaLaTeX. Во втором случае будет использован Times New Roman.

Файлы в папке `official-example-cp1251/` взяты с http://jetpletters.ru/ru/info.shtml. *Эти файлы являются произведением их авторов; владелец данного репозитория ни в коем случае не претендует на их авторство.*

### Опции класса

* `onlynames`       - печатает путь к изображению вместо его самого
* `smallerfigures`  - делает изображения чуть меньше
* `colorcite`       - включает подсветку отсутствующих `\cite` и `\ref`
* `colorref`        - то же


#### Определенные команды

`\insertfigure{путь}` - вставляет изображение

`\red{текст}` - красит текст в красный (не определено в `jetpl.cls`). 
Аналогично `\blue{текст}` и `\green{текст}`


##### Пример вставки рисунка

Пример годится как для `jetpl.cls`, так и для `jetpl2article.cls`.

```latex
\documentclass{jetpl2article}
% ИЛИ
\documentclass{jetpl}

\providecommand{\insertfigure}[1]{\fbox{#1}}
\providecommand{\red}[1]{#1}
\providecommand{\green}[1]{#1}
\providecommand{\blue}[1]{#1}
```

```latex
\begin{figure}
\centering
\insertfigure{path-to-pdf.pdf}
\caption{Подпись}
\label{fig1}
\end{figure}
```
