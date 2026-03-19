FROM alphine:latest    #pulls alphine image for linux environment

RUN apk add --no-cache bash procps  #installs bash with ps for top commands 

CMD ["/bin/bash", "-c" , "echo 'container running'; whoami; ls -al/; sleep infinity"]  # prints message , shows the user in alphine, lists out the root directory contents, makes container alive
