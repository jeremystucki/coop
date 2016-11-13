cmake_minimum_required(VERSION 3.6)
project(Coop)

file(GLOB SOURCES Sources/*.swift Packages/*/Sources/*/*/*.swift)

add_custom_target(Coop
        COMMAND swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR} SOURCES ${SOURCES} Package.swift)
