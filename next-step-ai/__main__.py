"""Main entry point for the Next-Step AI application."""

import sys


def main():
    """Execute the main application logic based on command-line arguments."""
    if len(sys.argv) < 2:
        print("Please provide a command.")
        print("Available commands: generate, process, train, run")
        sys.exit(1)

    command = sys.argv[1]

    try:
        from src.data.generators.generate import generate
        from src.data.preprocessors.preprocess import preprocess
        from src.models.train.train import train

        if command == "generate":
            print("Generating synthetic dataset...")
            generate()
        elif command == "process":
            print("Processing data...")
            preprocess()
        elif command == "train":
            print("Training model...")
            train()
        elif command == "run":
            print("Running all steps...")
            print("\nStep 1: Generating synthetic dataset...")
            generate()
            print("\nStep 2: Processing data...")
            preprocess()
            print("\nStep 3: Training model...")
            train()
        else:
            print(f"Unknown command: {command}")
            print("Available commands: generate, process, train, run")
            sys.exit(1)

    except ImportError as e:
        print(f"Error: Could not import required module. {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    main()
