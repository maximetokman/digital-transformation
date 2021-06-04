import re
from string import punctuation
from nltk.corpus import stopwords

files = ["dickinson", "algorithms", "americanah", "story"]

for f in files:
    print(f)
    file = open(f"data/{f}.txt", errors="ignore")
    file_text = file.readlines()
    arr_words = []
    # print(file_text)
    file_wcount = {}
    # split words by commas and spaces
    for line in file_text:
        arr_words += re.split(",|\\s", line)
    # remove blank elements
    arr_words = list(filter(lambda w:w != "", arr_words))
    # remove punctuation
    arr_words = [w.strip(punctuation) for w in arr_words]
    # convert to lowercase
    arr_words = [w.lower() for w in arr_words]
    # remove common words
    common_words = set(stopwords.words("english"))
    arr_words = [w for w in arr_words if w not in common_words]

    # update word count dict
    for word in arr_words:
        file_wcount[word] = file_wcount.get(word, 0) + 1

    # write word counts to csv
    with open(f"text_transformation/data/{f}.csv", "w") as csv_out:
        csv_out.write("Word, Count\n")
        for word in list(file_wcount.keys()):
            csv_out.write(f"{word}, {file_wcount[word]}\n")

