# OpenMetadataIO

The goal of OpenMetadataIO (OMIO) is to define an open, industry standard for interacting with MovieLabs’s OMC schema. Ultimately we will build a reference implementation of this API on top of Google Cloud technologies such as BigQuery and Spanner; however in the meantime the goal is to get the industry aligned on an interface.

## Problem Statement
We need a way to ensure metadata consistency and to provide a standard method for integrating software throughout the pre-production and production process, without relying on the export/import functions of individual applications. 

## Introducing OpenMetadataIO
Standardized data access throughout the media workflow
* A REST-based API for performing CRUDL (create, read, update, delete and list) operations against metadata
* OpenAPI-backed API spec allows for rapid mocking and automatic generation of client code
* Metadata stored in Google Cloud Spanner, which offers external consistency, role-based access control and massive scale
* Builds on MovieLabs’s Ontology for Media Creation (OMC) to deliver a standardized data model throughout the supply chain
