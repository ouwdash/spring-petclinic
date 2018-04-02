if curl -s "localhost:8080" | grep "Welkom"
then
    # if the keyword is in the conent
    echo "[SUCCESS] De applicatie werkt :)"
else
    echo "[FAILED] Webserver is down :("
fi
