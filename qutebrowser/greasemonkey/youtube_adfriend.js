// ==UserScript==
// @name        YouTube Adfriend
// @description Gain control/personalize your advertisement experience on YouTube.
// @namespace   Ryunigia
// @author      Ryunigia
// @homepage    http://glennmoreels.eu/
// @icon        https://image.flaticon.com/icons/png/128/174/174883.png
// @include     http://www.youtube.com/*
// @include     https://www.youtube.com/*
// @exclude     https://www.youtube.com/embed/*
// @exclude     http://www.youtube.com/embed/*
// @exclude     https://www.youtube.com/user/*
// @exclude     http://www.youtube.com/user/*
// @require     http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js
// @require     https://gist.github.com/raw/2625891/waitForKeyElements.js
// @version     0.781
// @grant       GM_addStyle
// @grant       GM_getValue
// @grant       GM_setValue
// @license     MIT
// ==/UserScript==
var AdVolumeMultiplier = GM_getValue("SoundMultiplier", 0.07);
var CountDownSeconds = GM_getValue("MovieCountDown", 4);
var CurrentCountDownSeconds = CountDownSeconds;
var BannerCountDownSeconds = GM_getValue("BannerCountDown", 12);
var CurrentBannerCountDownSeconds = BannerCountDownSeconds;
var BannerOpaque = GM_getValue("BannerOpacity", 0.4);
var AddSubscriberNoBlock = GM_getValue("AddSubscriberNoBlock", false);
var oldVolume = 0.5;
var UIContainer;
var skipContainer;
var closeContainer;
var video;
var button;
var InputBox;
var SkipBannerInputBox;
var SoundInputBox;
var OpacityInputBox;
var AddSubscriberNoBlockInputBox;

// only when add
var videoClassName = ".html5-main-video";
// skip
var videoAddSkippContainerClassName_Try1 = ".videoAdUiSkipContainer";
var videoAddSkippContainerClassName_Try2 = ".ytp-ad-skip-button-container";
var videoAddSkippContainerClassName = videoAddSkippContainerClassName_Try1;
var videoAddSkippClassName_Try1 = ".videoAdUiSkipButton";
var videoAddSkippClassName_Try2 = ".ytp-ad-skip-button";
var videoAddSkippClassName = videoAddSkippClassName_Try1;
// UI
var videoAddUIClassName_Try1 = ".videoAdUi";
var videoAddUIClassName_Try2 = ".ytp-ad-player-overlay";
var videoAddUIClassName = videoAddUIClassName_Try1;
// Banner
var bannerContainerName_Try1 = ".ima-container";
var bannerContainerName_Try2 = ".ytp-ad-overlay-container";
var bannerContainerName = bannerContainerName_Try1;
var closeButtonName_Try1 = ".ytp-ad-overlay-close-container";
var closeButtonName_Try2 = ".svg-close-button";
var closeButtonName = closeButtonName;
// volume
var volumeLowered = false;
var volumeSliderName = ".ytp-volume-panel";

// on video load
waitForKeyElements (videoClassName, OnVideoLoad);
function OnVideoLoad(jNode)
{
    // video
    video = document.querySelector(videoClassName);
    ConsoleMessage("Video found with volume of:" + video.volume);
    //oldVolume = video.volume;
}
function ConsoleMessage(text)
{
    console.log("Adfriend: "+ text);
}
waitForKeyElements (videoAddUIClassName_Try1, AdDetected);
waitForKeyElements (videoAddUIClassName_Try2, AdDetected);
function AdDetected (jNode)
{   
    //Check if the ad is stil there
    UIContainer = document.querySelector(videoAddUIClassName);
    if (!UIContainer) UIContainer = document.querySelector(videoAddUIClassName = videoAddUIClassName_Try2);
    // skip
    skipContainer = document.querySelector(videoAddSkippContainerClassName);
    if (!skipContainer) skipContainer = document.querySelector(videoAddSkippContainerClassName = videoAddSkippContainerClassName_Try2);
    if (!volumeLowered)
    {
        ConsoleMessage("original volume was:" + video.volume);
        var volumeButton = document.querySelector(volumeSliderName);
        oldVolume = volumeButton.getAttribute('aria-valuenow') * 0.01;
        volumeLowered = true;
        document.querySelector('video').playbackRate = 10;
    }
    // button
    button = document.querySelector(videoAddSkippClassName);
    if (!button) button = document.querySelector(videoAddSkippClassName = videoAddSkippClassName_Try2);

    // Continue
    if(UIContainer)
    {
        console.log("Adfriend: Add detected");
        setTimeout( QuickSoundCheck, 100 );
        setTimeout( CheckIfSkipable, 1000);
    }
}
//Check if the skip button is visible
function CheckIfSkipable(jNode)
{
    skipContainer = document.querySelector(videoAddSkippContainerClassName);
    if(skipContainer != null && skipContainer.style.display != "none")
    {
        console.log("Adfriend: movie ad countdown started");
        CurrentCountDownSeconds = CountDownSeconds;
        CountDownToSkip();
    }
    else if (UIContainer)
    {
        console.log("Adfriend: could not find skipcontainer:" + videoAddSkippContainerClassName + " - retrying");
        // try find
        skipContainer = document.querySelector(videoAddSkippContainerClassName = videoAddSkippContainerClassName_Try1);
        if (!skipContainer) skipContainer = document.querySelector(videoAddSkippContainerClassName = videoAddSkippContainerClassName_Try2);
        setTimeout( CheckIfSkipable, 1000);
    }
    else
    {
        console.log("adfriend: there was no adv?");
    }
}
// Count until skip
function CountDownToSkip(jNode)
{
    --CurrentCountDownSeconds;
    console.log("Adfriend: counting down: "+CurrentCountDownSeconds);
    if(button)
        button.textContent = "Skip in "+CurrentCountDownSeconds;
    else 
    {
        console.log("Adfriend:Could not find button");
        button = document.querySelector(videoAddSkippClassName = videoAddSkippClassName_Try1);
        if (!button) button = document.querySelector(videoAddSkippClassName = videoAddSkippClassName_Try2);

        if(button)
            CountDownToSkip();
        else
        {
            console.log("Adfriend:no button, ad is possibly skipped");
            return;
        }
    }
    if(CurrentCountDownSeconds < 1)
        SkipAd();
    else
        setTimeout( CountDownToSkip, 1000);
}
// REDUCE SOUND
function QuickSoundCheck(jNode)
{
    //check if ad
    UIContainer = document.querySelector(videoAddUIClassName);
    if(UIContainer)
    {
        //console.log("Add detected: current Volume:"+ video.volume + " vs old:" + oldVolume);
        if(video.volume > oldVolume * AdVolumeMultiplier)
        {
            console.log("Adfriend: volume was readjusted: "+video.volume);
            video.volume = oldVolume * AdVolumeMultiplier;
            console.log("Adfriend: Lowered to:"+video.volume);
        }
        setTimeout(QuickSoundCheck,100);
        return;
    }
    
    //add is gone
    console.log("Adfriend: Add is gone, moving volume back to: "+oldVolume);
    video.volume = oldVolume;
    volumeLowered = false;

    // check if sound is actually correct in a bit
    setTimeout(AdditionalSoundCheck, 500);
}
// is the sound still lowered?
function AdditionalSoundCheck(jNode)
{
    //check if ad
    UIContainer = document.querySelector(videoAddUIClassName);
    if(!UIContainer)
    {
        if(video.volume < oldVolume)
        {
            console.log("Adfriend: volume lowered somehow: "+video.volume);
            video.volume = oldVolume;
            console.log("Adfriend: readjusted to:"+video.volume);

            //setTimeout(QuickSoundCheck,500);
        }
        else console.log("Adfriend: sound seems good");
    }
    else console.log("Adfriend: Add persists");
}
// SKIP THE ADD, WHEN THEBUTTON IS AVAILABLE
function SkipAd(jNode)
{
    //retry
    button = document.querySelector(videoAddSkippClassName);
    UIContainer = document.querySelector(videoAddUIClassName);
    
    if(button)
    {
        console.log("Adfriend: Skipping ad");
        button.click();
    }
    else if(UIContainer)
    {
        console.log("Adfriend: Can't skip this potentially overpayed advertisement, sorry folks");
        return;
    }
    
    button = document.querySelector(videoAddSkippClassName);
    if(button)
    {
        console.log("Adfriend: Did a new adv appear? or did it fail?");
        setTimeout(CheckIfSkipable, 1000);
    }
    else
    {
        console.log("Adfriend: Ad was successfully skipped~");
    }
}

// CHECK IF SUBSCRIBED and create ui
function checkSubscribed (jNode) 
{
    // check it
    if ( ! /noblock/.test (window.location.href) ) 
    {
        console.log("Adfriend: Checking subscription");
        var elem = document.querySelector("#watch7-headline");
        if(elem)
        {
            if(AddSubscriberNoBlock)
            {
                var child = elem.children[0].children[1];
                if (child)
                {
                    if (child.getAttribute("data-is-subscribed") == 'True')
                    {
                        location.replace (location.href + "&noblock");
                    }
                }
            }
        }
        else
        {
            var subscribebox = document.querySelector("#subscribe-button");
            var child = subscribebox.children[0].children[0];
            if(child)
            {
                //if()
                var subscribed = child.getAttribute("subscribed");
                if(subscribed !== null)
                    location.replace (location.href + "&noblock");
                else
                {
                    console.log("Adfriend: not subscribed?");
                    //console.log(child);
                    //console.log(subscribed);
                }
            }
            else
            {
                console.log("Adfriend: Could not find subscribe box");
            }
        }
    }
}
//waitForKeyElements ("#watch7-subscription-container", checkSubscribed);
//waitForKeyElements ("#watch7-headline", checkSubscribed);
function AddUI (jNode)
{
    var adfriend = document.querySelector("#Adfriend");
    if(adfriend)
    {
        ConsoleMessage("was already added");
    }
    else
    {
        //Our interface container
        var newspan = document.createElement("SPAN");
        newspan.className = "date style-scope ytd-video-secondary-info-renderer";
        newspan.style.display = "inline-block";
        newspan.id = "Adfriend";
        newspan.style.marginLeft = "5px";
        newspan.style.marginTop = "5px";
        // old system or new system?
        var header = document.querySelector("#placeholder-player");
        if(!header) header = document.querySelector("#info");
        if(header)
            ConsoleMessage("Found suitable ui container!");
        else
            ConsoleMessage("Can't find place to add ui container..");
        header.appendChild(newspan);
        //Information
        var textnode = document.createTextNode("Adfriend::Movie:skip:");
        newspan.appendChild(textnode);

        //Input
        InputBox = document.createElement("input");
        InputBox.type = "number";
        InputBox.style.width = "25px";
        InputBox.defaultValue = CountDownSeconds;
        InputBox.oninput = saveValue;
        newspan.appendChild(InputBox);

        textnode = document.createTextNode("sound%:");
        newspan.appendChild(textnode);
        //Input
        SoundInputBox = document.createElement("input");
        SoundInputBox.type = "number";
        SoundInputBox.style.width = "35px";
        SoundInputBox.defaultValue = AdVolumeMultiplier * 100;
        SoundInputBox.oninput = saveValue;
        newspan.appendChild(SoundInputBox);

        textnode = document.createTextNode("Banner:skip:");
        newspan.appendChild(textnode);

        SkipBannerInputBox = document.createElement("input");
        SkipBannerInputBox.type = "number";
        SkipBannerInputBox.style.width = "35px";
        SkipBannerInputBox.defaultValue = BannerCountDownSeconds;
        SkipBannerInputBox.oninput = saveValue;
        newspan.appendChild(SkipBannerInputBox);

        textnode = document.createTextNode("Opacity%:");
        newspan.appendChild(textnode);

        OpacityInputBox = document.createElement("input");
        OpacityInputBox.type = "number";
        OpacityInputBox.style.width = "35px";
        OpacityInputBox.defaultValue = BannerOpaque * 100;
        OpacityInputBox.oninput = saveValue;
        newspan.appendChild(OpacityInputBox);

        //AddSubscriberNoBlock
        textnode = document.createTextNode("sub&noblock:");
        //newspan.appendChild(textnode);

        AddSubscriberNoBlockInputBox = document.createElement("input");
        AddSubscriberNoBlockInputBox.type = "checkbox";
        //AddSubscriberNoBlockInputBox.style.width = "35px";
        AddSubscriberNoBlockInputBox.checked = AddSubscriberNoBlock;
        AddSubscriberNoBlockInputBox.onclick = saveValueNoblock;
        //newspan.appendChild(AddSubscriberNoBlockInputBox);
    }
}
waitForKeyElements ("#player-container", AddUI);
waitForKeyElements ("#placeholder-player", AddUI);
function saveValue()
{
    CountDownSeconds = InputBox.value;
    GM_setValue("MovieCountDown", CountDownSeconds);
    
    BannerCountDownSeconds = SkipBannerInputBox.value;
    GM_setValue("BannerCountDown", BannerCountDownSeconds);
    
    AdVolumeMultiplier = SoundInputBox.value / 100;
    GM_setValue("SoundMultiplier", AdVolumeMultiplier);
    
    BannerOpaque = OpacityInputBox.value / 100;
    GM_setValue("BannerOpacity", BannerOpaque);
}
function saveValueNoblock()
{
    AddSubscriberNoBlock = AddSubscriberNoBlockInputBox.checked;
    GM_setValue("AddSubscriberNoBlock", AddSubscriberNoBlock);   
}


//make banner ads transparent
waitForKeyElements (bannerContainerName_Try1, bannerFound);
waitForKeyElements (bannerContainerName_Try2, bannerFound);
function bannerFound(jnode)
{
    var bannerContainer = document.querySelector(bannerContainerName = bannerContainerName_Try1);
    if (!bannerContainer) bannerContainer = document.querySelector(bannerContainerName = bannerContainerName_Try2)
    bannerContainer.style.opacity = BannerOpaque;
    //bannerContainer.style.transition = "";
    CurrentBannerCountDownSeconds = BannerCountDownSeconds;
    console.log("Adfriend: Banner ad detected: applying opacity");
    
    //<div class="close-padding"><a class="close-button" title="Close" role="button" tabindex="0"></a></div>
    var closeParent = document.querySelector(closeButtonName = closeButtonName_Try1);
    if (!closeParent) closeParent = document.querySelector(closeButtonName = closeButtonName_Try2);

    // found close button?
    if(!closeParent)
        console.log("Adfriend: failed to find closebutton:" + closeButtonName);

    closeContainer = document.createElement("SPAN");
    closeParent.appendChild(closeContainer);

    // created succes?
    if (!closeContainer)
        console.log("Adfriend: failed to create close container");

    //var countDownText = document.createTextNode(""+BannerCountDownSeconds);
    closeContainer.appendChild(document.createTextNode(BannerCountDownSeconds));
    setTimeout(CloseBannerCountDown,1000); 
}
var stopHiding = false;
function CloseBannerCountDown()
{
    stopHiding = true;
    var bannerContainer = document.querySelector(bannerContainerName);
    if (!bannerContainer)
    {
        ConsoleMessage("Could not find a banner?");
        return;
    }

    bannerContainer.style.opacity = BannerOpaque;
    --CurrentBannerCountDownSeconds;
        closeContainer.textContent = CurrentBannerCountDownSeconds;
    if(CurrentBannerCountDownSeconds < 1)
        CloseBannerAd();
    else
        setTimeout( CloseBannerCountDown, 1000);
}
function CloseBannerAd()
{
//    var closeButton = document.querySelector(".ad-container ad-container-single-media-element-annotations ad-overlay");
//    if(closeButton)
//        closeButton.style.height = "0px";
//        closeButton.click();

    var bannerContainer = document.querySelector(bannerContainerName);
    if (bannerContainer)
        bannerContainer.style.opacity = 0.0;
    var closeButton = document.querySelector(closeButtonName);
    if(closeButton)
    {
        console.log("Adfriend: Banner ad still active, keeping it hidden");
        setTimeout(CloseBannerAd,1000);
    }
    //else
    //{
     //   stopHiding = false;
     //   console.log("Adfriend: succesfully closed banner ad");
     //   CurrentBannerCountDownSeconds = BannerCountDownSeconds;
     //   //bannerContainer.style.transition = "";
     //   setTimeout(KeepAdHidden, 3000);
    //}
}
function KeepAdHidden()
{
    var bannerContainer = document.querySelector(bannerContainerName);
    if(bannerContainer.style.opacity != 0.0)
        bannerContainer.style.opacity = 0.0;
    if(!stopHiding)
        setTimeout(KeepAdHidden, 3000);
}
