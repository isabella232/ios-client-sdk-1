Change Log
==========

## Version 1.1.0
---------------------------------

### ***Breaking Changes***

#### Renamed
- MeetingService -> MeetingServiceProtocol
- LoggingService -> LoggingServiceProtocol
- VideoDeviceService -> VideoDeviceServiceProtocol
- AudioDeviceService -> AudioDeviceServiceProtocol
- meetingService.leaveAndEndMeeting(kickoutDelayInSeconds: Int) -> meetingService.moderatorControlsService.endMeetingForAllParticipants(timeInSeconds: Int)]
- BJNMeeting -> MeetingInformation, meetingService.meetingInfo -> meetingService.meetingInformation

#### Removed
- ConnectionState (Use MeetingState instead)
- maxVideoBandwith removed from meetingService.join(...), can still be set as meetingService.maxVideoBandwith = ... before joining.

### Feature Additions
- ModeratorControlsService
    - Check if the client has moderator privileges
    - Start and stop recording
    - Mute the audio or video of one, or all participants
    - Drop a participant from the meeting
    - isModerator flag added to BJNParticipant
- Waiting Room Support
    - Join a waiting room enabled meeting
    - Added `.waitingRoom` to MeetingState
    - Events for approval, denial, meeting ended and demotion to waiting room.
- Waiting Room Moderation Support
    - View participants in the waiting room
    - Enable/disable waiting room
    - Check if a meeting supports waiting room
    - Admit or deny one or all participants in the WR
    - Demote a participant back to the WR
- Closed Caption Support
    - Check if the meeting supports Closed Captioning
    - Enable/disable closed captioning for the client
    - Observe the closed caption text
- Debugging Improvements
    - enableAudioCaptureDump(_ enable: Bool) 
- Remote Stream Enablement
    - Mute the remote video stream
    - Mute the remote content stream
- Meeting Information
    - Meeting ID added
    - Participant passcode added
    - Meeting owner username added
- PrivateChatService
    - isPrivateChatAvailable flag added - private chat can be disabled in some meetings.


Version 1.0.0 
---------------------------------
Features:

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
- Remote Video mute
- Meeting Information (Title, Hostname, Meeting Id)
