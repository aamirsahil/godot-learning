\# Godot-learning



Create an Android swiping game to learn Godot.



---



\## Clone the repository



```bash

git clone https://github.com/aamirsahil/godot-learning.git

cd godot-learning

```



---



\## Switch to the `dev` branch



```bash

git checkout dev

```



If the `dev` branch does not exist locally:



```bash

git fetch

git checkout dev

```



---



\## Create a feature branch for your work



Always create a new branch for each feature or fix.



```bash

git checkout -b feature/<your-feature-name>

```



Example:

```bash

git checkout -b feature/swipe-input

```



---



\## Before starting work (keep your branch up to date)



```bash

git checkout dev

git pull origin dev

git checkout feature/<your-feature-name>

git merge dev

```



---



\## Commit changes and push your branch



```bash

git add .

git commit -m "Describe your changes"

git push origin feature/<your-feature-name>

```



---



\## Create a Pull Request



1\. Go to the GitHub repository

2\. Create a Pull Request from `feature/<your-feature-name>` to `dev`

3\. Add one reviewer

4\. Merge only after approval



---



\## Rules



\- ❌ Do not push directly to `dev`

\- ✅ One feature or fix per branch

\- ✅ Always sync `dev` before starting work

