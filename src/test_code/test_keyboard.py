#!/usr/bin/env python
#coding: utf-8
from evdev import InputDevice
from select import select

def detectInputKey():
    dev = InputDevice('/dev/input/event4')
    while True:
        select([dev], [], [])
        for event in dev.read():
            print "code:%s value:%s" % (event.code, event.value)


def detectInputKey2():
    dev = InputDevice('/dev/input/event4')
    while True:
        select([dev], [], [])
        for event in dev.read():
            if (event.value == 1 or event.value == 0) and event.code != 0:
                print "Key: %s Status: %s" % (event.code, "pressed" if event.value else "release")

if __name__ == '__main__':
    print("asdf")
    detectInputKey2()
    print("a2sdf")