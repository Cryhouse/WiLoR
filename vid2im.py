import os
import subprocess


def vid2ims(video_path, output_dir, framerate=30):
	os.makedirs(output_dir, exist_ok=True)
	ffmpeg_command = f"ffmpeg -i {video_path} -vf fps={framerate} {os.path.join(output_dir,'%04d.png')}"
	subprocess.run(ffmpeg_command.split())

def ims2vid(image_dir, output_video_path, framerate=30):
	os.makedirs(os.path.dirname(output_video_path), exist_ok=True)
	command = f"ffmpeg -framerate {framerate} -i {os.path.join(image_dir, '%04d.png')} -c:v libx264 -pix_fmt yuv420p {output_video_path}"
	subprocess.run(command)