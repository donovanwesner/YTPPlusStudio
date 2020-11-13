using Godot;
using System;

public class Studio : Control
{
	public VideoPlayer player;
	public Button playButton;
	public enum PlayState
	{
		NotPlaying,
		Playing,
		Paused
	}
	public PlayState playing = PlayState.NotPlaying;
	public override void _Ready()
	{
		player = GetNode<VideoPlayer>("Main/TabContainer/Theater/VideoPlayer");
		playButton = GetNode<Button>("Main/TabContainer/Theater/Play");
	}
	private void _on_Play_pressed()
	{
		switch(playing)
		{
			case PlayState.NotPlaying:
				player.Play();
				playing = PlayState.Playing;
				playButton.Text = "Pause";
				break;
			case PlayState.Playing:
				player.Paused = true;
				playing = PlayState.Paused;
				playButton.Text = "Resume";
				break;
			case PlayState.Paused:
				player.Paused = false;
				playing = PlayState.Playing;
				playButton.Text = "Pause";
				break;
		}
	}
}
