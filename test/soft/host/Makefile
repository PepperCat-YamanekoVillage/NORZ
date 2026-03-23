PORT ?= /dev/cu.usbserial-1140
RUN_OPTS ?= --half-cycle-us 100 --cycles 300 --strict-reg

setup:
	python3 -m venv .venv && \
	source .venv/bin/activate && \
	pip install pyserial

device:
	platformio device list

run:
	source .venv/bin/activate && python run_tests.py --port $(PORT)

test:
	source .venv/bin/activate && python run_tests.py --port $(PORT) $(RUN_OPTS) > log-test-all.txt

clean:
	rm -rf .venv
