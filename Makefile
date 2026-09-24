# Download dependencies under ./dependencies
init-standalone:
	west init -l config --mf west-standalone.yml
	west update --narrow
	west zephyr-export

# Download dependencies under ../
init-workspace:
	west init -l . --mf config/west.yml
	west update --narrow
	west zephyr-export

build-all:
	west zmk-build -d ./build -q

debug-all:
	west zmk-build -S zmk-usb-logging
