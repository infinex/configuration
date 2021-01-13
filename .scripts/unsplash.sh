SEARCH=nature
while true; do

   #rm ./index.html?$SEARCH  
   wget https://source.unsplash.com/3440x1440/?$SEARCH >/dev/null 2>&1

   # Converting picture
   mv ./index.html?$SEARCH ./wp.jpg

   # Setting wallpaper
   feh --bg-scale wp.jpg

   sleep 1
done
