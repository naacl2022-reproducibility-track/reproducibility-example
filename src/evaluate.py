import argparse
import json
from rouge_score import rouge_scorer

METRICS = ["rouge1", "rouge2"]


def main(args):
    scorer = rouge_scorer.RougeScorer(METRICS)
    scores = []
    with open(args.reference_file, "r") as f_ref:
        with open(args.prediction_file, "r") as f_pred:
            for reference, prediction in zip(f_ref, f_pred):
                scores.append(scorer.score(reference, prediction))

    averages = {metric: 0.0 for metric in METRICS}
    for score_dict in scores:
        for metric in METRICS:
            averages[metric] += score_dict[metric].fmeasure / len(scores)

    # Round to decrease likelihood of floating point differences
    rounded = {metric: f"{value * 100:.2f}" for metric, value in averages.items()}

    print(json.dumps(rounded))


if __name__ == '__main__':
    argp = argparse.ArgumentParser()
    argp.add_argument("--reference-file", required=True)
    argp.add_argument("--prediction-file", required=True)
    args = argp.parse_args()
    main(args)