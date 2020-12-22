from subprocess import call

if __name__ == "__main__":
	for i in range(3):
		call(["screencapture", "{}.jpg".format(i)])
