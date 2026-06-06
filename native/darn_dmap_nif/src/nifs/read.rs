use crate::encode::NifDmapField;
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
                let records = dmap::[<read_ $name>](&path)
                    .map_err(to_nif_error)?
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok(records)
            }

            #[rustler::nif]
            pub fn [<read_ $name _lax>](path: String) -> NifResult<(Vec<HashMap<String, NifDmapField>>, Option<usize>)> {
                let (records, bad_byte) = dmap::[<read_ $name _lax>](&path).map_err(to_nif_error)?;
                let records = records
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok((records, bad_byte))
            }

            #[rustler::nif]
            pub fn [<read_ $name _bytes>](bytes: Binary) -> NifResult<Vec<HashMap<String, NifDmapField>>> {
                let records = dmap::[<read_ $name _bytes>](bytes.as_slice())
                    .map_err(to_nif_error)?
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok(records)
            }

            #[rustler::nif]
            pub fn [<read_ $name _bytes_lax>](bytes: Binary) -> NifResult<(Vec<HashMap<String, NifDmapField>>, Option<usize>)> {
                let (records, bad_byte) = dmap::[<read_ $name _bytes_lax>](bytes.as_slice()).map_err(to_nif_error)?;
                let records = records
                    .into_iter()
                    .map(|record| nif_record(record.inner()))
                    .collect();

                Ok((records, bad_byte))
            }

            #[rustler::nif]
            pub fn [<sniff_ $name>](path: String) -> NifResult<HashMap<String, NifDmapField>> {
                dmap::[<sniff_ $name>](&path)
                    .map_err(to_nif_error)
                    .map(|record| nif_record(record.inner()))
            }

            #[rustler::nif]
            pub fn [<read_ $name _metadata>](path: String) -> NifResult<Vec<HashMap<String, NifDmapField>>> {
                let records = dmap::[<read_ $name _metadata>](&path)
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
