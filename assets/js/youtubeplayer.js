let player;

function onYouTubeIframeAPIReady(){
    player = new YT.Player('youtube-player', {
        events: {
            'onReady' : onPlayerReady,
            'onStateChange': onPlayerStateChange
        }
    });
}

function onPlayerReady(event) {
    console.log("Player is ready!");
}

function onPlayerStateChange(event) {
    
}

function togglePlay() {
    if (player && player.getPlayerState()) {
        const playerState = player.getPlayerState();

        if (playerState === YT.PlayerState.PLAYING) {
            player.pauseVideo();
        }
        else {
            player.playVideo();
        }

    }
}

