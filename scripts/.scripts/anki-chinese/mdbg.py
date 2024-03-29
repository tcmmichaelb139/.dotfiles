#!/usr/bin/env python3

import os
import re
import subprocess
import sys

import wget
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

# brew install chromedriver

assetDirectory = (
    "/Users/tcmb139/Library/Application Support/Anki2/User 1/collection.media"
)


def write_to_clipboard(output):
    process = subprocess.Popen(
        "pbcopy", env={"LANG": "en_US.UTF-8"}, stdin=subprocess.PIPE
    )
    process.communicate(output.encode("utf-8"))


def findStrokes(inp):
    print(inp)
    url = (
        "https://www.mdbg.net/chinese/dictionary?page=worddict&wdrst=0&wdqb={}".format(
            inp
        )
    )

    # service = Service("./chromedriver")
    options = webdriver.ChromeOptions()
    options.binary_location = (
        "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
    )
    options.add_argument("--headless")

    driver = webdriver.Chrome(options=options)

    print("loading", end="", flush=True)

    driver.get(url)

    rows = driver.find_elements(By.CLASS_NAME, "row")

    # Stroke animation

    for row in rows:
        e1 = row.find_element(
            By.XPATH, ".//a[@title='Show information about all characters']"
        )
        driver.execute_script("arguments[0].click();", e1)

    charresults = driver.find_elements(By.XPATH, "//table[@class='charresults']")
    print(".", end="", flush=True)

    while len(rows) != len(charresults):
        charresults = driver.find_elements(By.XPATH, "//table[@class='charresults']")
    print(".", end="", flush=True)

    for row in charresults:
        e2 = row.find_elements(By.XPATH, ".//a[@title='Show stroke order']")
        for e in e2:
            driver.execute_script("arguments[0].click();", e)
    print(".", end="", flush=True)

    while len(rows) != len(charresults):
        charresults = driver.find_elements(By.XPATH, "//table[@class='charresults']")
    print(".", end="", flush=True)

    strokeAndCharacters = []

    charsAdded = []

    for i in range(len(charresults)):
        try:
            WebDriverWait(driver, 1).until(
                EC.presence_of_element_located(
                    (By.XPATH, ".//img[@alt='Stroke animation']")
                )
            )
        except:
            continue

        print(".", end="", flush=True)

        e3 = charresults[i].find_elements(By.XPATH, ".//img[@alt='Stroke animation']")

        if len(e3) == 0:
            continue

        strokes = []

        for e in e3:
            strokes.append(e.get_attribute("src"))

        rowText = ""

        ops = 0

        while len(rowText) != len(strokes) and ops < 100:
            ops += 1
            rowText = (
                rows[i]
                .find_element(
                    By.XPATH, ".//a[@title='Show information about all characters']"
                )
                .text
            )

        if rowText in charsAdded:
            continue
        strokeAndCharacters.append((rowText, strokes))
        charsAdded.append(rowText)

        if rowText == inp:
            break

    print(".")

    driver.quit()

    whichStroke = -1

    for i in range(len(strokeAndCharacters)):
        if inp == strokeAndCharacters[i][0]:
            whichStroke = i
            break

    if whichStroke == -1:
        for i in range(len(strokeAndCharacters)):
            print(i, strokeAndCharacters[i][0])

        whichStroke = 0

        if len(strokeAndCharacters) > 1:
            whichStroke = int(input("Which stroke do you want to see? "))

    if whichStroke >= len(strokeAndCharacters) or whichStroke < 0:
        print("Could not find stroke for " + inp)
        return ""

    allStrokes = ""

    for stroke in strokeAndCharacters[whichStroke][1]:
        allStrokes += "<img src='{}' />".format(re.findall(r"[^/]+(?=/$|$)", stroke)[0])
        if not os.path.exists(
            assetDirectory + "/" + re.findall(r"[^/]+(?=/$|$)", stroke)[0]
        ):
            wget.download(stroke, out=assetDirectory)

    return allStrokes


def main():
    # try:
    allStrokes = ""
    for i in range(1, len(sys.argv)):
        if sys.argv[i] != "":
            allStrokes += findStrokes(sys.argv[i])
    if allStrokes == "":
        inp = input("Enter pinyin/characters: ")
        inp = inp.split(" ")
        for i in inp:
            if i != "":
                allStrokes += findStrokes(i)
    print()
    print(allStrokes)
    write_to_clipboard(allStrokes)
    # except:
    #     print("Something went wrong")
