# Normalization

`Normalization` is a systematic approach of decomposing tables to eliminate data redundancy(repetition) and undesirable characteristics like `Insertion, Update and Deletion Anomalies`.

  `Update anomalies` − If data items are scattered and are not linked to each other properly, then it could lead to strange situations. For example, when we try to update one data item having its copies scattered over several places, a few instances get updated properly while a few others are left with old values. Such instances leave the database in an inconsistent state.

  `Deletion anomalies` − We tried to delete a record, but parts of it was left undeleted because of unawareness, the data is also saved somewhere else.

  `Insert anomalies` − We tried to insert data in a record that does not exist at all.


`Student Table` → `Zip Code Table` → `City Table` => Transitive dependency
