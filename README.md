## OpenProductionDataIO
The goal of the OpenProductionDataIO (OPDIO) project is to define an open industry standard for interacting with production metadata. You can view the complete API documentation at: https://googlecloudplatform.github.io/opdio/

## Problem Statement
We need a way to ensure metadata consistency and to provide a standard method for integrating software throughout the pre-production and production process, without relying on the export/import functions of individual applications. 

## Introducing OpenProductionDataIO
Standardized data access throughout the media workflow
* A REST-based API for performing CRUDL (create, read, update, delete and list) operations against metadata
* OpenAPI-backed API spec allows for rapid mocking and automatic generation of client code
* Builds on MovieLabs’s Ontology for Media Creation (OMC) to deliver a standardized data model throughout the supply chain

## Technology and Design Choices
We've selected OpenAPI v3.1 as the specification standard because it supports direct import of JSON schema; this allows
us to keep pace with developments in the MovieLabs Ontology while retaining the ability to version our own API.

We are also aligning with (Google's API Improvement Proposals)[https://www.aip.dev] to ensure we are providing a state-of-the-art API design that remains accessible and easy to understand.
