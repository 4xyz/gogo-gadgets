# Load libraries
from pandas import read_csv
from pandas.plotting import scatter_matrix
from matplotlib import pyplot
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import StratifiedKFold
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
from pathlib import Path

# Load dataset
url = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv"
names = ["sepal-length", "sepal-width", "petal-length", "petal-width", "class"]
dataset = read_csv(url, names=names)
current_dir = Path(__file__).parent.absolute()
work_dir = Path(current_dir) / ".workdir"


def pyplot_img(format="png"):
    import base64
    from io import BytesIO

    bio = BytesIO()
    pyplot.savefig(bio, format=format)
    return (
        f'<img src="data:image/{format};base64,'
        f'{base64.b64encode(bio.getvalue()).decode("utf-8").strip()}"/>'
    )


def main():
    print("=== shape ===")
    print(dataset.shape)
    print("=== head ===")
    print(dataset.head(20))
    print("=== descriptions ===")
    print(dataset.describe())
    print("=== class distribution ===")
    print(dataset.groupby("class").size())

    # box and whisker plots
    dataset.plot(kind="box", subplots=True, layout=(2, 2), sharex=False, sharey=False)
    pyplot.savefig(str(work_dir / "iris_datset_box.png"))

    # histograms
    dataset.hist()
    pyplot.savefig(str(work_dir / "iris_datset_hist.png"))

    # scatter plot matrix
    scatter_matrix(dataset)
    pyplot.savefig(str(work_dir / "iris_datset_scatter_matrix.png"))
    print(pyplot_img())


if __name__ == "__main__":
    # execute only if run as a script
    main()
