# syntax=docker/dockerfile:1

# ============================================================================
# r-singlecell
#
# Reproducible R and Bioconductor environment for single-cell bioinformatics 
# with Seurat, BPCells, Monocle3, CellChat, clusterProfiler, and related tools.
#
# Source:
#   https://github.com/umehina/r-singlecell
#
# Registry:
#   ghcr.io/umehina/r-singlecell
#
# Base:
#   R 4.6.1
#   Bioconductor 3.23
# ============================================================================

ARG BASE_IMAGE=ghcr.io/bioconductor/bioconductor_docker:3.23-R-4.6.1
FROM ${BASE_IMAGE}
USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
    && rm -rf /var/lib/apt/lists/*

RUN R -q -e ' \
    pak::pkg_install("beachmat"); \
    pak::cache_clean() \
' && rm -rf /tmp/*

RUN R -q -e ' \
    options(Ncpus = 2); \
    pak::pkg_install(c( \
        "Seurat", \
        "SeuratObject", \
        "spatstat.explore", \
        "patchwork", \
        "openxlsx", \
        "tiff", \
        "tidyverse", \
        "readxl", \
        "cowplot", \
        "ggnewscale", \
        "NMF", \
        "R.utils", \
        "circlize", \
        "bioc::SingleCellExperiment", \
        "bioc::SummarizedExperiment", \
        "bioc::scater", \
        "bioc::scran", \
        "bioc::scuttle", \
        "bioc::batchelor", \
        "bioc::HDF5Array", \
        "bioc::glmGamPoi", \
        "bioc::clusterProfiler", \
        "bioc::org.Mm.eg.db", \
        "bioc::GenomicRanges", \
        "bioc::ComplexHeatmap" \
    )); \
    pak::cache_clean() \
' && rm -rf /tmp/*

RUN R -q -e ' \
    options(Ncpus = 2); \
    pak::pkg_install(c( \
        "BPCells=github::bnprks/BPCells/r", \
        "monocle3=github::cole-trapnell-lab/monocle3@v1.4.27", \
        "presto=github::immunogenomics/presto", \
        "SeuratWrappers=github::satijalab/seurat-wrappers", \
        "SeuratData=github::satijalab/seurat-data", \
        "CellChat=github::jinworks/CellChat" \
    )); \
    pak::cache_clean() \
' && rm -rf /tmp/*

RUN mkdir -p /workspace && \
    chown rstudio:rstudio /workspace

WORKDIR /workspace

USER rstudio

RUN R -q -e ' \
    pkgs <- c( \
        "Seurat", \
        "SeuratObject", \
        "ggplot2", \
        "dplyr", \
        "tibble", \
        "openxlsx", \
        "clusterProfiler", \
        "org.Mm.eg.db", \
        "presto", \
        "spatstat.explore", \
        "patchwork", \
        "tiff", \
        "monocle3", \
        "SeuratWrappers", \
        "tidyverse", \
        "SeuratData", \
        "readxl", \
        "CellChat", \
        "GenomicRanges", \
        "cowplot", \
        "ggnewscale", \
        "BPCells", \
        "SingleCellExperiment", \
        "Matrix", \
        "matrixStats", \
        "tools" \
    ); \
    missing <- pkgs[ \
        !vapply(pkgs, requireNamespace, logical(1), quietly = TRUE) \
    ]; \
    if (length(missing)) { \
        stop( \
            "Missing packages: ", \
            paste(missing, collapse = ", ") \
        ); \
    }; \
    cat("\nAll required R packages are installed and accessible.\n\n") \
'

ARG BASE_IMAGE
ARG IMAGE_VERSION=dev
ARG BUILD_DATE
ARG VCS_REF

LABEL org.opencontainers.image.title="r-singlecell" \
      org.opencontainers.image.description="Reproducible R and Bioconductor environment for single-cell bioinformatics with Seurat, BPCells, Monocle3, CellChat, clusterProfiler, and related tools." \
      org.opencontainers.image.authors="umehina (https://github.com/umehina)" \
      org.opencontainers.image.vendor="umehina" \
      org.opencontainers.image.url="https://github.com/umehina/r-singlecell" \
      org.opencontainers.image.documentation="https://github.com/umehina/r-singlecell#readme" \
      org.opencontainers.image.source="https://github.com/umehina/r-singlecell" \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.revision="${VCS_REF}" \
      org.opencontainers.image.created="${BUILD_DATE}" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.base.name="${BASE_IMAGE}" \
      io.github.umehina.r-singlecell.r-version="4.6.1" \
      io.github.umehina.r-singlecell.bioconductor-version="3.23" \
      io.github.umehina.r-singlecell.package-manager="pak"

CMD ["R", "--vanilla"]