[![BlueJeans iOS Client Software Development Kit](https://user-images.githubusercontent.com/23289872/127987669-3842046b-2f08-46e4-9949-6bf0cdb45d95.png "BlueJeans iOS Client Software Development Kit")](https://www.bluejeans.com "BlueJeans iOS Client Software Development Kit")

# BlueJeans iOS Client Software Development Kit

The BlueJeans iOS Client Software Development Kit (SDK) enables the embedding BlueJeans Video and Audio capabilities into iOS apps. `BlueJeansSDK` is a single namespace that encapsulates all the API's related to establishing and managing a BlueJeans Video and Audio connection.

The design of the SDK emphasizes **simplicity**. Developers can quickly integrate BlueJeans video into their applications.

## Features :
- Audio and Video Permission handling
- Join, End Meeting
- Self Video
- Remote Video, Remote Video states
- Content receive 
- Audio and Video self mute
- Orientation handling
- Toggle front / back camera
- Video Layout switch
- Participant list
- Participant properties: Audio mute state, Video mute state, is Self, Name and Unique Identifier
- Self Participant
- Screen Share
- Log Upload
- Multi-stream support ("Sequin" Video Layouts)
- Public and Private meeting Chat
- Remote Video and Content mute
- Meeting Information (Title, Hostname, Meeting Id, Participant passcode)

## Current Version : 1.0.0

## Pre-requisites :
This framework requires ***Swift 5.4*** and ***Xcode 12.5***. Module stability will be provided in a future release. 

Target deployment requires a minimum of *iOS version 13.0*.

There are additional software dependencies on frameworks as mentioned in the [**Dependencies**](#dependencies) section. All dependent frameworks are included as part of the frameworks bundle.

## API Architecture
[TBD]

![iOS Client SDK API Structure](https://user-images.githubusercontent.com/23289872/131215117-4629fab3-35ec-47a1-891c-517623b4e7b5.png)


## SDK Documentation :
Detailed documentation of SDK functions is available[TBD] [here](https://bluejeans.github.io/android-client-sdk)

## How do I start?
You can experience BlueJeans meetings using the iOS client SDK by following the two steps below:

### Generate a meeting ID :
As a prerequisite to using the BlueJeans iOS Client SDK to join meetings, you need a BlueJeans meeting ID. If you do not have a meeting ID then you can create one using a BlueJeans account:

   - Sign up for a BlueJeans Account either by opting in for a [trial](https://www.bluejeans.com/free-video-conferencing-trial) or a [paid account](https://store.bluejeans.com/)
   - Once the account is created, you can schedule a meeting either by using the account or through the [direct API](https://bluejeans.github.io/api-rest-howto/schedule.html) calls. In order to enable API calls on your account, please reach out to [support team](https://support.bluejeans.com/s/contactsupport).

### Integrate BlueJeans iOS Client SDK
Integrate the SDK using the below guidelines and use SDK APIs to join a meeting using the generated meeting ID. 

## Integration Steps :
### Manual

Steps:

1. Download `ios-client-sdk.zip` 
2. Unzip the file and copy `ios-client-sdk` folder to the root folder where Xcode project(*xxxx.xcodeproj* file) is located.
3. Open the Xcode project, click on the project build settings and select the *App target -> General Tab*.
4. Scroll to ***Embedded Binaries*** section of Xcode target.
5. Select all frameworks found in `ios-client-sdk/XCFrameworks` folder *except BlueJeansSDK.xcframework*.
6. Drag and drop all frameworks present in `ios-client-sdk/Frameworks` folder to this section. Make sure the project settings looks like below image after adding it.

[TBD - update image without screen sharing extension]
![Xcode Project Build Setting - General Tab](Images/xcodegeneralsettings.png)

### SPM, Carthage and Cocoapods

Other dependency managers, such as the Swift package manager, Cartjage or Cocoapods are not currently supported.

### Upgrade Instructions
Whenever a newer version of SDK is available, you can consume it by replacing the xcframeworks with the newer versions.

## Setup

#### Bitcode Support
BlueJeans iOS Client SDK cannot support bitcode. To integrate this SDK into your application, you will have to disable bitcode for the target. 

To disable bitcode:

1. Go to Build Settings tab of Xcode application target in Xcode project settings. 
2. Search for ***"Enable Bitcode"*** 
3. Change the value to ***"No"***

#### Manual Copy Frameworks Script
The iOS Client SDK relies on a framework named BlueJeansSDK which is built only for real devices. In order for your app to work for both simulator and real devices, you must not embed this framework in the normal way. Instead use the provided embed-device-only-framework.sh script as a Run Script phase at the end of the build. This should copy the BlueJeansSDK framework at build time. You should have a run script build phase as pictured.

[TBD update image with "correct" path]
![Xcode Project Build Setting - General Tab](Images/embed-device-only.png)

If you only want to use the app on physical devices you can skip this step and just embed the BlueJeansSDK framework like all of the others. 

#### User Permissions
In iOS, the user must explicitly grant app permission to access device cameras or microphones for video, or audio capture. Your app must provide an explanation for its use of these capture devices. Failure to do so will result in a crash.

Audio/Video permissions must be requested by the App developer *before* the first meeting join otherwise audio *will not work for the first meeting*, this should be done at a time convenient to the user. See the [Apple Documentation](https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture/requesting_authorization_for_media_capture_on_ios) for details on how to do this, or use the helper methods in BlueJeansSDK.PermissionService [TBD link]

Open your application's `Info.plist` and provide a short explanation for both of these `Info.plist` keys: 

- ***NSCameraUsageDescription*** *(Privacy - Camera Usage Description)* 
- ***NSMicrophoneUsageDescription*** *(Privacy - Microphone Usage Description)* 

iOS displays this prompt when asking the user for permission, and thereafter in the Settings app. See [Apple documentation](https://developer.apple.com/documentation/avfoundation/cameras_and_media_capture) for more details.

![Info.plist updates](Images/plist.png)

## Initialize the BlueJeans SDK :

The work needed to add the BlueJeans functionality into your application code is outlined here. Briefly, you will do these steps:

- Include the BlueJeans `BJNClientSDK` module, and initialize the SDK by calling the `BlueJeansSDK.initalize` method.
- Create a video view for the *Self view*, add and position the remote video view controller, and if desired *Content Share view*.
- Make the API call to Join the BlueJeans Meeting.
- When finished, make the API call to Leave the BlueJeans Meeting.

*There!* That is the extent of the work you need to do to make your application join its first BlueJeans meeting.

### Include Module

**Swift:**
```swift
import BJNClientSDK
```
### Setup 

[TBD] Explain services (perhaps add others we need here in the samples below, e.g. videoDeviceService)
`meetingService` can be accessed as:

**Swift:**
```swift
let meetingService = BlueJeansSDK.meetingService
```

## Join a BlueJeans meeting :

To connect to a Video/Audio meeting,

**Swift:**
```swift
meetingService.join(meetingID: "111111111", passcode: "1111", displayName: "John Doe", onSuccess: {
    print("Join meeting: Success")
}, onFailure: {})
```

## Leave a meeting

To disconnect from the meeting,

**Swift:**
```swift
meetingService.leave()
```

## Adding video

### Adding Remote video
BlueJeans video uses a system that receives multiple streams of video and audio and on the client joins these together to create different layouts. This complexity is handled by the Remote Video View Controller. To use this controller, instantiate it with the code:

```swift
remoteVideoViewController = videoDeviceService.getRemoteVideoController()
```
and add it to your view using view controller containment. For example:

[TBD - missing a step when adding the VC?]
```swift
addChild(self.remoteVideoViewController)
view.addSubview(self.remoteVideoViewController.view)
remoteVideoViewController.didMove(toParent: self)
setupRemoteVideoContraints()
```

Ensure that the added view has a set of unambigous auto-layout constraints.

### Adding Self and Content Share views

The Self and Content Share views can be added as follows:

1. Create a container view (e.g. `videoContainer`) in Storyboard, XIB or code.
2. Setup AutoLayout constraints for `videoContainer` view.
3. Add the self or content share view as described below.

```swift
guard let videoView = videoDeviceService.getSelfViewInstance() else { return }
videoContainer.addSubview(videoView)
//Set constraints programatically for top, bottom, left and right anchors
videoView.translatesAutoresizingMaskIntoConstraints = false
videoView.leftAnchor.constraint(equalTo: videoContainer.leftAnchor).isActive = true
videoView.rightAnchor.constraint(equalTo: videoContainer.rightAnchor).isActive = true
videoView.topAnchor.constraint(equalTo: videoContainer.topAnchor).isActive = true
videoView.bottomAnchor.constraint(equalTo: videoContainer.bottomAnchor).isActive = true
```
Similar code can be used with `getContentShareInstance` in place of `getSelfViewVideoInstance` to add it to your view hierarchy.

### Self Video View Rotation

Note that the size / aspect ratio of the self view can change as the device is rotated. Currently this is between 3:4 (portrait) and 4:3 (landscape), but is likely to also include 9:16 and 16:9 in future releases.

To handle these changes (and many other properties), the SDK provides *observable properties* that allow you to react whenever they change. In this case you need to observe the *VideoDeviceService.selfViewSize*  property as follows:

**Swift:**
```swift
videoDeviceService.selfViewSize.onChange {
    print("Self view size changed to ", videoDeviceService.selfViewSize.value)
    // Update self view container size
}
```
### Logging

The iOS Client SDK will record logs. If you have experienced an issue you can upload these logs, with a comment and email for us to diagnose the issue.

**Swift:**
```swift
let loggingService = BlueJeansSDK.loggingService // This will instantiate the logger, do this early in the lifecycle of your applicaton.

loggingService.uploadLogs(comments: "Issue with the SDK", username: "abc@yourcompany.com") { uploadResult in
    print("Log Upload Finished")
}
```
`BlueJeansSDK` uses `CocoaLumberjack` and should respect log levels set at the app level.

## Meeting Service :
This service takes care of all meeting-related APIs. Apart from meeting related APIs, the service also provides provides for several inMeeting services - ParticipantsService, AudioDeviceService, ContentShareService, PublicChatService, and PrivateChatService.

### Video Layouts :

Represents how remote participants videos are composed
- **Speaker** : Only the most recent speaker is shown, taking up the whole video stream.
- **People** : The most recent speaker is shown as a larger video. A filmstrip of the next (up to) 5 most recent speakers is shown at the top.
- **Gallery** : A bunch of the most recent speakers is shown, arranged in a grid layout of equal sizes.

*videoLayout* provides for the current video layout *setVideoLayout* can be used to force a Video Layout of your choice.

Note that by default the current layout will be the People layout or it will be the one chosen by the meeting scheduler in his accounts meeting settings.


#### Different layouts, number of tiles :
- `Speaker layout` to fit one single active speaker participant
- `People layout` to fit max 6 participants, 1 (main active speaker participant) + 5 (film strip participants)
- `Gallery layout` can fit maximum number of participant tiles as 9 or 25 depending on SDK input configuration. By default it is 9 participants, ordered in 3x3 style. This is configurable to support max of 25 participants, ordered in 5x5 style

#### Configuring 5x5 in gallery layout:
BlueJeansSDKInitParams provides a new input parameter called videoConfiguration which can be set with value GalleryLayoutConfiguration.FiveByFive. It is recommended to set this only on larger form factor (>= 7") devices for a better visual experience. Note that using 5x5 will consume higher memory, CPU and battery as compared to other layouts

### Remote Video :

The BlueJeans SDK's RemoteVideoFragment provides for both the audio and video participant tiles. The organization and the ordering of these tiles depend on factors namely recent dominant speaker and meeting layout, in addition to an algorithm that ensures minimal movement of tiles when the recent speaker changes. Video participants are given the priority and are put first in the list and then the audio participants follow.

Note: MultiStream mode is not supported on devices with a number of CPU cores less than six. In such cases, RemoteVideoFragment would receive a single composited stream (participant's videos are stitched at the server, organized based on the layout chosen and a single stream is served to the client).

#### Participant background colour : 

By default, the participant tile when video is turned off shows a colour gradient with colour as blue at 90 degrees. This gradient colour and the gradient angle can be changed by the consumer app.

Below are the steps to achieve the same:

- Create a file with the name bjn_background_participant_tile.xml 
- Add a shape with the colour and gradient angle as per your choice into the file. Find the sample for the shape as below
```java
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android"
    android:shape="rectangle">
    <gradient
        android:angle="90"
        android:endColor="#073571"
        android:startColor="#6589a4" />
</shape>
```
- Save and copy the file to the application resource drawable folder 
- Build, Run the project
  
### Video Resolutions and BW consumption:

- Video receive resolution and BW max:

| Layout       | Max participants| Layout pattern for max participants| Video Receive max resolution, FPS                         | Video Receive BW max |
| -------------|:---------------:| :---------------------------------:| :--------------------------------------------------------:|:--------------------:|
| Speaker View | 1               | 1                                  | 640x360/640x480  30fps                                    | 600 kbps             |
| People View  | 6               | 1 (main stage) + 5 (film strip)    | main stage 640x360/640x480 30fps (if single participant)  | 600 kbps             |
|              |                 |                                    | main stage 320x180/240x180 30fps (if > 1 participant)     | 300 kbps             |
|              |                 |                                    | film strip 160x90/120x90, 15fps                           | 400 kbps             |
| Gallery View | 9               | 3x3 (landscape) / 4x2+1 (portrait) | 640x360/640x480 (participants < 2)      30 fps            | 1200 kbps            |
|              |                 |                                    | 320x180/240x180 (participants > 2, < 4) 30 fps            | 1200 kbps            |
|              |                 |                                    | 160x90/120x90  (participants > 4)       15 fps            | 900 kbps             |
|              |                 |                                    | 160x90/120x90  (participants > 9)       15 fps            | 1700 kbps            |

- Content receive resolution and BW max: 1920x1080 at 5 fps, 300 kbps
- Video send resolution and BW max: 640x480 at 30fps, 900 kbps

Note: Endpoints that send video in an aspect ratio of 4:3 instead of 16:9, will result in video receive a resolution of 640x480 in place of 640x360, 240x180 in place of 320x180, and 120x90 in place of 160x90. Mobile endpoints / BlueJeans android SDK endpoints send video at 640x480 i.e at an aspect ratio of 4:3.

### Mute:

The BluejeansSDK provides APIs to mute/unmute self video.

`enableSelfVideoPreview` of VideoDeviceService controls video device enablement. This drives the self video preview.
`setVideoMuted` of MeetingService will mute/unmute the self video stream flowing to the other endpoint. This API additionally triggers self video preview states internally.
 Available when meeting state moves to MeetingState.Connected

Note that
- video mute state applied on `enableSelfVideoPreview` needs to be applied to `setVideoMuted` once meeting state changes to MeetingState.Connected.
- when in a meeting (meeting state is MeetingState.Connected) and if `setVideoMuted` is called with true, `enableSelfVideoPreview` is called with true,
then the self video preview gets activated but the stream does not flow to the other endpoint.

#### Mute/Unmute Remote Video :
The BluejeansSDK MeetingService provides API to mute, unmute remote participants video. This is helpful in the scenarios where the user does not intend to view remote video.
Some example use cases can be
- App has a view pager with the first page showing remote video and the second page showing content. When a user is on the content page, this API can be used to mute remote video.
- To provide an audio only mode
- App going in the background
**Note:** This API does not give instant result, this may take up to 5 sec in case of back-to-back requests.

##### API:
`meetingService.setRemoteVideoMuted(muted: Boolean)`

#### Mute/Unmute Content :
The BluejeansSDK MeetingService provides API to mute, unmute content. This is helpful in the scenarios where the user does not intend to view content.
Some example use cases can be
- App has a view pager with the first page showing remote video and the second page showing content. When user a is on the video page, this API can be used to mute content.
- To provide an audio only mode
- App receiving content and goes in to the background
**Note:** This API does not give instant results, this may take up to 5sec in case of back-to-back requests. Unlike for video, we have a single API to mute content share and mute content receive. Ensure to call this only when you are not sharing the content from your end.

##### API :
`meetingService.setContentMuted(muted: Boolean)`

#### Background handling recommendations :
When the app is put to background and the user is out of the meeting: User's self video needs to be stopped to save CPU load, save battery
When the app is put to background and the user is in a meeting:
- User's self video needs to be stopped for privacy reasons
- Remote video and content receive should be muted to save bandwidth

and the same can be turned ON when the app is put back to the foreground.

These can be achieved using the set of mute APIs SDK provides.
Use `setVideoMuted` for managing self video flowing to other endpoints when in a meeting
Use `enableSelfVideoPreview` for managing the capturer when not in the meeting
Use `setRemoteVideoMuted` for managing remote participants videos when in a meeting
Use `setContentMuted` for managing content when in a meeting

## Audio Device Service (Audio device enumeration, Selection) :

```java
blueJeansSDK.getMeetingService().getAudioDeviceService()
```

*audioDevices* will provide a list of audio devices available on the hardware.

*currentAudioDevice* will provide for the current audio device selected.

On dynamic change in audio devices, SDK's default order of auto selection is as below:

- BluetoothHeadset
- USBDevice
- USBHeadset
- WiredHeadsetDevice
- WiredHeadPhones
- Speaker

Use *selectAudioDevice* and choose the audio device of your choice from the available *audioDevices* list.

## Participants Service :

```java
blueJeansSDK.getMeetingService().getParticipantsService()
```

*participant* represents a meeting participant. Carries properties video mute state, audio mute state, is self, name and a unique identifier of the participant.

*participants* provides for a list of meeting participants. The list will be published on any change in the number of meeting participants or the change in properties of any of the current participants. Any change will reflect in the content of the list and the list reference remains the same throughout the meeting instance.

*selfParticipant* represents self. Provides for any changes in properties of the self.

### Content Share Feature:

Provides facility to share content within the meeting, thereby enhances the collaborative experience of the meeting session. Our SDK currently supports content share in the form of full device's screen share which can be accessed via ContentShareService
```java
blueJeansSDK.getMeetingService().getContentShareService()
```

#### Sharing the Screen :
This is a full device screen share, where the SDK will have access to all of the information that is visible on the screen or played from your device while recording or casting. This includes information such as passwords, payment details, photos, messages, and audio that you play. This information about data captured is prompted to the user as a part of starting screen share permission consent dialog and the data populated within the dialog comes from android framework.

##### Feature pre requisites :
- Permission to capture screen data using android's Media Projection Manager
- Foreground service

##### Sample code to ask permission :

      MediaProjectionManager mediaProjectionManager = (MediaProjectionManager) getSystemService(Context.MEDIA_PROJECTION_SERVICE);
      startActivityForResult(mediaProjectionManager.createScreenCaptureIntent(), SCREEN_SHARE_REQUEST_CODE);

The above request will result in a permission dialog like

<img width="320" alt="ScreenSharePermissionDialog" src="https://user-images.githubusercontent.com/23289872/114588998-e2e28e00-9ca4-11eb-850c-7b0396a068fd.png">

Note that, this is a system prompted dialog where the name in the dialog will be the app name and the content is predefined by the Android System.

##### Start foreground service, Screen Share :
Once you get the result of the permission, start a service and then invoke _startContentShare_ API :

**Note:** If you already have a foreground service running for the meeting, then an explicit service for screen sharing is not needed.
Apps targeting SDK version `Build.VERSION_CODES.Q` or later should specify the foreground service type using the attribute `R.attr.foregroundServiceType`
in the service element of the app's manifest file as below

      <service
         android:name=".YourForegroundService"
         android:stopWithTask="true"
         android:foregroundServiceType="mediaProjection"/>

##### Invoke content share start API :

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        switch (requestCode) {
            case SCREEN_SHARE_REQUEST_CODE:
                if (data != null) {
                     startYourForegroundService() // start your service if there is not one already for meeting
                     contentShareService.startContentShare(new ContentShareType.Screen(data));
                }
                break;
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

### Start Share API :
`startContentShare(contentShareType: ContentShareType)`

### Stop Share API :
`stopContentShare()`

#### Observables with Screen Share feature :
- contentShareState - provides for screen share current state
- contentShareEvent - provides for screen share events
- contentShareAvailability - provides for information about content share feature being available or not. Content share may not be available in cases such as an access disabled by a moderator, access disabled by admin, due to lack of meeting privilege, and enablement of a moderator only share.

#### User experience recommendation :
Whenever Screen Share starts,
- Put the app to the background thereby easing the user to chose the screen/app of his choice
- Have an overlay floater button out of the app, which can be used to stopping the screen share
- Stopping screen share using the floater button can bring the app back to the foreground
- Put an overlay border around the screen to indicate that the screen share is in progress

## Meeting Chat Feature :
The Bluejeans SDK's MeetingService provides a facility to chat within the meeting with participants present in the meeting. The chat will remain during the
duration of the meeting and will be cleared once the meeting is over.

There are two types of chat services available

## Public Chat Service :
The service provides APIs to message all participants present in the meeting at once i.e. All the participants present in the meeting, will receive the message sent through the service.

**Note:** Whenever a new user joins or reconnection happens only the last 10 public messages are restored.

#### API :
`meetingService.publicChatService.sendMessage(message: String): Boolean` </br>

## Private Chat Service :
The service provides APIs to message individual participants present in the meeting i.e. Only the participant given as input to API will get the message. All participants present in the meeting may or may not
be eligible for a private chat. The service provides a list of eligible participants and only those participants will be available for a private chat.

**Note:** Whenever a participant disconnects and connects back in the same meeting, it is treated as a new user, and previous chat messages if any will not be retained.

#### API :
`meetingService.privateChatService.sendMessage(message: String, participant: Participant): Boolean`

There Rx Subscriptions are provided by each of the chat services to listen to the message and unread message count. Please refer to the API documentation for more details.

## ModeratorControlsService :
This is an in-meeting service that provides for moderator privileged controls. This is available only for a moderator.
`isModeratorControlsAvailable` can be checked for the service availability.

As a moderator, one can perform
- meeting recording start, stop
- mute, unmute participant's / all participants audio
- mute, unmute participant's / all participants video
- remove a participant from the meeting
- end the meeting for all immediately / after a certain delay

Note that 
- ModeratorControlsService cannot override the local audio, video mute operations performed by the participants.
- Participants can locally override the mute enforcements by the ModeratorControlsService

Please refer to dokka documentation for details on the API set and the corresponding observables.

## Logging Service :
Uploads logs stored at internal app storage to BlueJeans SDK internal log server. The API takes user comments and the user name.
The name of the user serves as a unique identifier for us to identify the logs uploaded.

#### API :
`uploadLog(comments: String, username: String): Single<LogUploadResult>`

#### Single Result :
AlreadyUploading, Success, Failed

Logging Service also provides for API to generate audio capture dumps,which use to report any audio related issues such as no audio, low audio, echo, etc.
The audio capture dump created will be placed inside the internal app directory and uploaded to BlueJeans log server and the app logs, on calling the `uploadLog` API. Once the upload is successful, the dump will be cleared from the internal memory.
Note that the audio capture dumps will be heavier in size and use it only when needed, ensure to capture for 30 sec while u reproduce the issue and
upload them once captured.

#### API :
`enableAudioCaptureDump(enable: Boolean)`

## Subscriptions (ObservableValue and Rx Single's) :

#### RxSingle : 
This is a standard [Rx Single](http://reactivex.io/RxJava/javadoc/io/reactivex/Single.html)

#### ObservableValue :

Most of our subscriptions are stateful members called ObservableValues. 
These are our BJN custom reactive stream elements carrying a value that can be accessed (READ only) at any point of time and also allows a subscription. Through ObservableValue you can also access [RxObservable](http://reactivex.io/RxJava/javadoc/io/reactivex/Observable.html) and subscribe.

Sample app depicts the usage of both the RxSingle and ObeservableValue

#### ObservableEvent :

Unlike state observables, these wont carry a value that can accessed anytime. These are Fire and forget events which can mainly be used for notification banners and are generally provided in addition to the stateful variables and are to be used if necessary. These will be of type plain rx observable where u can use subscribeOn and ObserveOn from Rx library.


## SDK Sample Application :
We have bundled two sample apps in this repo. One for Java and another for kotlin.
It showcases the integration of BlueJeans SDK for permission flow and joins the flow. They have got a basic UI functionality and orientation support.

## Tracking & Analytics :
BlueJeans collects data from app clients who integrate with SDK to join BlueJeans meetings like Device information (ID, OS, etc.), Location, and usage data.

## Contributing :
The BlueJeans Android Client SDK is closed source and proprietary. As a result, we cannot accept pull requests. However, we enthusiastically welcome feedback on how to make our SDK better. If you think you have found a bug, or have an improvement or feature request, please file a GitHub issue and we will get back to you. Thanks in advance for your help!

## License : 
Copyright © 2021 BlueJeans Network. All usage of the SDK is subject to the Developer Agreement that can be found [here](LICENSE). Download the agreement and send an email to api-sdk@bluejeans.com with a signed version of this agreement, before any commercial or public facing usage of this SDK.

## Legal Requirements :
Use of this SDK is subject to our [Terms & Conditions](https://www.bluejeans.com/terms-and-conditions-may-2020) and [Privacy Policy](https://www.bluejeans.com/privacy-policy). 
