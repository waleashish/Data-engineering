import os
import argparse
import pandas as pd
from sqlalchemy import create_engine

def main(args):
    # Create the postgres engine
    url = f"postgresql://{args.user}:{args.password}@{args.host}:{args.port}/{args.db}"
    engine = create_engine(url=url)

    # Download csv
    save_file_name = "output.csv.gz"
    csv_file_name = "output.csv"
    os.system(f"wget {args.url} -O {save_file_name}")
    os.system(f"gzip -d {save_file_name}")
    print(args.url[:-3])
    df_iterator = pd.read_csv(csv_file_name, iterator=True, chunksize=100000)

    print("Inserting records into database...")
    chunk = 1
    while (True):
        try:
            df = next(df_iterator)
            df.to_sql("YELLOW_TAXI_DATA", con=engine, if_exists="append")
            print(f"Inserted chunk {chunk} of records into our database...")
            chunk += 1
        except StopIteration:
            print(f"All the values from csv are inserted into our database.")
            break


if __name__ == '__main__' :
    parser = argparse.ArgumentParser()
    parser.add_argument("--user", help="User name for postgres")
    parser.add_argument("--password", help="Password for postgres")
    parser.add_argument("--host", help="Host for postgres")
    parser.add_argument("--port", help="Port for postgres")
    parser.add_argument("--db", help="Database name for postgres")
    parser.add_argument("--url", help="String URL for data file]")

    main(parser.parse_args())