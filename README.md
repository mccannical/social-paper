# start.sh
### Takes a list of youtube IDs, downloads the comments in json, and converts them to tsv. 

steps to run:
- Gather a list of youtube videos:  
    List:  
    - https://www.youtube.com/watch?v=Wgnr_ftHhUw&t=22s  
    - https://www.youtube.com/watch?v=Kl-J7CRkvFw&t=198s  
    - https://www.youtube.com/watch?v=vUXZ86Z4Zfs  
    - https://www.youtube.com/watch?v=LPNNJeNhKD0  
    ### The ID is here: `https://www.youtube.com/watch?v=`ID-Is-Here`&t=22s`
    Remove beginning and end:   
    - remove "https://www.youtube.com/watch?v="   
    - remove "&t=" to the end of the line  
    ## Store these in list/videos  
    Wgnr_ftHhUw  
    Kl-J7CRkvFw  
    vUXZ86Z4Zfs  
    LPNNJeNhKD0  

- Run ./start.sh  
  -  A directory "data" will be created.
  - Under this a raw, proc, and comments dir will be created.  
    - Raw contains json comments, plus all attributes
    - proc contains tsv version of the json
    - comments has the count of comments embedded in the filename.  

- Upload the comments folder to google drive.  
- Integrate MonkeyLearn to Google Sheets
    - [Instructions from Monkey Learn](https://monkeylearn.com/google-sheets)  
- Add API key to the tool  
- Start processing files to get the sentiment analysis  





