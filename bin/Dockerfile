# continuumio/miniconda3:4.8.2
FROM continuumio/miniconda3@sha256:456e3196bf3ffb13fee7c9216db4b18b5e6f4d37090b31df3e0309926e98cfe2

LABEL name="CUBE manifest parser" \
      description="Tools required for CUBE manifest parser" \
      maintainer="Sangram Keshari Sahu <sangram@lifebit.ai>"

RUN apt-get update \
  && apt-get install procps -y \
  && pip install csvkit
