use crate::encode::NifDmapField;
use dmap::DmapRecord;
use dmap::FitacfRecord;
use dmap::GridRecord;
use dmap::IqdatRecord;
use dmap::MapRecord;
use dmap::RawacfRecord;
use dmap::SndRecord;
use dmap::types::DmapField;
use dmap::DmapError;
use dmap::Record;
use indexmap::IndexMap;
use paste::paste;
use rustler::{Binary, Error, NifResult};
use std::collections::HashMap;

fn to_nif_error(err: DmapError) -> Error {
    Error::Term(Box::new(err.to_string()))
}

fn nif_record(record: IndexMap<String, DmapField>) -> HashMap<String, NifDmapField> {
    record.into_iter().map(|(k, v)| (k, v.into())).collect()
}

macro_rules! read_nif {
    ($name:ident, $record:ty) => {
        paste! {
            #[rustler::nif]
            pub fn [<read_ $name>](path: String) -> NifResult<Vec<HashMap<String, NifDmapField>>> {
                let records = <$record>::read_file(&path) //dmap::[<read_ $name>](&path)
                    .map_err(to_nif_error)?
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok(records)
            }

            #[rustler::nif]
            pub fn [<read_ $name _lax>](path: String) -> NifResult<(Vec<HashMap<String, NifDmapField>>, Option<usize>)> {
                let (records, bad_byte) = <$record>::read_file_lax(&path).map_err(to_nif_error)?;
                let records = records
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok((records, bad_byte))
            }

            #[rustler::nif]
            pub fn [<read_ $name _bytes>](bytes: Binary) -> NifResult<Vec<HashMap<String, NifDmapField>>> {
                let records = <$record>::read_records(bytes.as_slice())
                    .map_err(to_nif_error)?
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok(records)
            }

            #[rustler::nif]
            pub fn [<read_ $name _bytes_lax>](bytes: Binary) -> NifResult<(Vec<HashMap<String, NifDmapField>>, Option<usize>)> {
                let (records, bad_byte) = <$record>::read_records_lax(bytes.as_slice()).map_err(to_nif_error)?;
                let records = records
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok((records, bad_byte))
            }

            #[rustler::nif]
            pub fn [<read_ $name _by_indices>](path: String, indices: Vec<i32>) -> NifResult<Vec<HashMap<String, NifDmapField>>> {
                let records = <$record>::read_file_by_indices(&path, &indices)
                    .map_err(to_nif_error)?
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok(records)
            }

            #[rustler::nif]
            pub fn [<read_ $name _by_indices_lax>](path: String, indices: Vec<i32>) -> NifResult<(Vec<HashMap<String, NifDmapField>>, Option<usize>)> {
                let (records, bad_byte) = <$record>::read_file_by_indices_lax(&path, &indices).map_err(to_nif_error)?;
                let records = records
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok((records, bad_byte))
            }

            #[rustler::nif]
            pub fn [<read_ $name _bytes_by_indices>](bytes: Binary, indices: Vec<i32>) -> NifResult<Vec<HashMap<String, NifDmapField>>> {
                let records = <$record>::read_nth_records(bytes.as_slice(), &indices)
                    .map_err(to_nif_error)?
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok(records)
            }

            #[rustler::nif]
            pub fn [<read_ $name _bytes_by_indices_lax>](bytes: Binary, indices: Vec<i32>) -> NifResult<(Vec<HashMap<String, NifDmapField>>, Option<usize>)> {
                let (records, bad_byte) = <$record>::read_nth_records_lax(bytes.as_slice(), &indices).map_err(to_nif_error)?;
                let records = records
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok((records, bad_byte))
            }

            #[rustler::nif]
            pub fn [<read_ $name _metadata>](path: String) -> NifResult<Vec<HashMap<String, NifDmapField>>> {
                let records = <$record>::read_file_metadata(&path)
                    .map_err(to_nif_error)?
                    .into_iter()
                    .map(nif_record)
                    .collect();

                Ok(records)
            }

            #[rustler::nif]
            pub fn [<read_ $name _metadata_by_indices>](path: String, indices: Vec<i32>) -> NifResult<Vec<HashMap<String, NifDmapField>>> {
                let records = <$record>::read_file_metadata_by_indices(&path, &indices)
                    .map_err(to_nif_error)?
                    .into_iter()
                    .map(nif_record)
                    .collect();

                Ok(records)
            }
        }
    };
}

read_nif!(iqdat, IqdatRecord);
read_nif!(rawacf, RawacfRecord);
read_nif!(fitacf, FitacfRecord);
read_nif!(grid, GridRecord);
read_nif!(map, MapRecord);
read_nif!(snd, SndRecord);
read_nif!(dmap, DmapRecord);
