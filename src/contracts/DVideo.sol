pragma solidity ^0.5.0;

// 1. Model the video
// 2. store the video
// 3. upload video
// 4. list videos

contract DVideo {
  uint public videoCount = 0;
  string public name = "DVideo";
  //2. store the video, Create id=>struct mapping
  mapping(uint => Video) public videos;    //name of the mapping = videos, uint is the same as uint id in struct, Video is the struct Video.
// 1. model the video
  //Create Struct
  struct Video {
    uint id;       //unsigned integer (number)
    string hash;   //the hash from IPFS
    string title;  //the video title
    address author;  //the uploader public address
  }

  //Create Event
  event VideoUploaded(
      uint id,
      string hash,
      string title,
      address author
  );

  constructor() public {
  }

  function uploadVideo(string memory _videoHash, string memory _title) public {
    // Make sure the video hash exists (requirement)
    require(bytes(_videoHash).length > 0);
    // Make sure video title exists (requirement)
    require(bytes(_title).length > 0);
    // Make sure uploader address exists (requirement), address(0) means empty address.
    require(msg.sender!=address(0));

    // Increment video id  (using counter cash)
    //videoCount = videoCount + 1; or use short cut below:
    videoCount ++;
    // Add & save video to the contract
    videos[videoCount] = Video(videoCount, _videoHash, _title, msg.sender);

    // Trigger an event
    emit VideoUploaded(videoCount, _videoHash, _title, msg.sender);
  }
}
