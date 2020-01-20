
git add raw_notebook/

lst=$(git status -s | grep -G -o -e "\(raw_notebook[^ .]*[.]ipynb$\)")

if [[ -n "$lst" ]]; then
  mkdir temp
  cp --parent "$lst" temp/

  jupyter nbconvert $(find temp/ -name '*.ipynb')
  rm $(find temp/ -name '*.ipynb')
  rsync -a temp/raw_notebook/ notebook/

  rm -r temp/

  apindex notebook/
  git add notebook/
  git commit -m 'auto commit'
  git push
fi
