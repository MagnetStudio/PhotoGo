# PhotoGo
This is just a simple application that show how to upload a image to a photo share site.

----

Hi guys!

I will show you something that using Imgur API to upload your pictures to a web site.   
This application really works well, so, please be very careful with the pictures which you want to upload and public to Imgur website.   



### How to build:
After you download the source, I think you should do some changes with Xcode build settings likes these below,   
The sources have been built with Xcode7.3.1 and run successfully at iOS9.3.2.   

    Target->PhotoGo->General->Identity->Team:Your own Team ID
    Target->PhotoGo->Capabilities->App Groups->App Groups:Your own App Groups
    Target->PhotoGoEx->General->Identity->Team:Your own Team ID(should be same as target:PhotoGo)
    Target->PhotoGoEx->Capabilities->App Groups->App Groups:Your own App Groups(should be same as target:PhotoGo)
    Target->PhotoLib->General->Identity->Team:Your own Team ID(should be same as target:PhotoGo)
     
Ok, please enjoy it!
