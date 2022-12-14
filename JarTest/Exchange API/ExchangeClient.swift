//
//  ExchangeClient.swift
//  JarTest
//
//  Created by Oleh Titov on 22.06.2022.
//

import Foundation

class ExchangeClient: ExchangeClientProtocol {
    
    /**
     Free, easy-to-use REST API interface delivering worldwide exchange rate data in JSON format.
     Source: https://moneyconvert.net/pages/api
     */
    let exchangeHost = "https://cdn.moneyconvert.net/api/latest.json"
    
    /**
     API does nor reqire any keys. There is only one endpoint which does not accept any parameters. So URL generation is pretty straightforward.
     */
    var url: URL {
        return URL(string: exchangeHost)!
    }
    
    /**
     Here is a generic method for requests of type GET. In case of decoding errors it shows the reason of failure.
     */
    private func getRequest<ResponseType: Decodable>(responseType: ResponseType.Type, urlRequest: URLRequest) async -> ResponseType? {
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest, delegate: .none)
            print(data)
            print(String(decoding: data, as: UTF8.self))
            let decoder = JSONDecoder()
            return try decoder.decode(ResponseType.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            return nil
        } catch DecodingError.valueNotFound(let type, let context) {
            Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            return nil
        } catch DecodingError.typeMismatch(let type, let context) {
            Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            return nil
        } catch DecodingError.dataCorrupted(let context) {
            Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            return nil
        } catch let error as NSError {
            NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            return nil
        } catch {
            return nil
        }
    }
    
    /**
     Asynchronous method to get the latest rates from API
     */
    func getLatestRates() async -> ForeignExchange? {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return await getRequest(responseType: ForeignExchange.self, urlRequest: request)
    }
    
    /**
     Method for testing purposes in order not to overuse the API
     */
    func getSampleRates() -> [String : Double] {
        return ["AED": 3.673, "AFN": 89, "ALL": 113.65, "AMD": 420.492563, "ANG": 1.803027, "AOA": 429.1786, "ARS": 124.241197, "AUD": 1.440752, "AWG": 1.8, "AZN": 1.7, "BAM": 1.856815, "BBD": 2, "BDT": 92.869631, "BGN": 1.851353, "BHD": 0.377024, "BIF": 2037, "BMD": 1, "BND": 1.389403, "BOB": 6.887899, "BRL": 5.2459, "BSD": 1, "BTC": 4.7416773e-05, "BTN": 78.283552, "BTS": 98.75631875, "BWP": 12.215239, "BYN": 3.377343, "BZD": 2.016567, "CAD": 1.291667, "CDF": 2000, "CHF": 0.955043, "CLF": 0.033191, "CLP": 915.55, "CNH": 6.682576, "CNY": 6.688, "COP": 4100.084727, "CRC": 691.657603, "CUC": 1, "CUP": 25.75, "CVE": 105.25, "CZK": 23.459, "DASH": 0.0198097024, "DJF": 178.102696, "DKK": 7.057906, "DOGE": 15.0485819048, "DOP": 54.61, "DZD": 145.797229, "EGP": 18.7728, "ERN": 15.000001, "ETB": 51.9, "ETH": 0.0008340588, "EUR": 0.948533, "FJD": 2.18685, "FKP": 0.813804, "GBP": 0.813804, "GEL": 2.94, "GGP": 0.813804, "GHS": 7.95, "GIP": 0.813804, "GMD": 53.95, "GNF": 8830, "GTQ": 7.753337, "GYD": 209.438578, "HKD": 7.84917, "HNL": 24.509999, "HRK": 7.1423, "HTG": 115.549569, "HUF": 380.0615, "IDR": 14830.85, "ILS": 3.411715, "IMP": 0.813804, "INR": 78.284502, "IQD": 1460, "IRR": 42250, "ISK": 132.49, "JEP": 0.813804, "JMD": 151.244609, "JOD": 0.709, "JPY": 135.2305, "KES": 117.7, "KGS": 79.50215, "KHR": 4066, "KMF": 468.950051, "KPW": 900, "KRW": 1291.34109, "KWD": 0.30658, "KYD": 0.833729, "KZT": 467.462907, "LAK": 15023.070665, "LBP": 1517, "LD": 320, "LKR": 360.153759, "LRD": 151.999978, "LSL": 15.99, "LTC": 0.0179731183, "LYD": 4.815, "MAD": 10.0415, "MDL": 19.199464, "MGA": 4057, "MKD": 58.396038, "MMK": 1852.292139, "MNT": 3127.2388, "MOP": 8.088651, "MRO": 356.999828, "MRU": 36.235, "MUR": 44.94883, "MVR": 15.4, "MWK": 1019.5, "MXN": 19.908887, "MYR": 4.40575, "MZN": 63.849999, "NAD": 15.99, "NGN": 414.99, "NIO": 35.86, "NOK": 9.87254, "NPR": 125.253958, "NXT": 296.26895625, "NZD": 1.584171, "OMR": 0.384999, "PAB": 1, "PEN": 3.745, "PGK": 3.52, "PHP": 54.900501, "PKR": 208.7, "PLN": 4.45807, "PYG": 6880.713633, "QAR": 3.641, "RON": 4.68974, "RSD": 111.345, "RUB": 53.950006, "RWF": 1028, "SAR": 3.752624, "SBD": 8.156656, "SCR": 13.083439, "SDG": 456.5, "SEK": 10.131638, "SGD": 1.387162, "SHP": 0.813804, "SLL": 13150.4, "SOS": 585.5, "SRD": 22.073, "SSP": 130.26, "STD": 21980.490504, "STN": 23.45, "STR": 7.9803085859, "SVC": 8.754059, "SYP": 2512.53, "SZL": 15.926291, "THB": 35.465544, "TJS": 10.048419, "TMT": 3.51, "TND": 3.102, "TOP": 2.344025, "TRY": 17.370085, "TTD": 6.799419, "TWD": 29.71785, "TZS": 2332.016, "UAH": 29.530445, "UGX": 3756.690756, "USD": 1, "UYU": 39.69662, "UZS": 10837.5, "VEF_BLKMKT": 5.22, "VEF_DICOM": 5.15, "VEF_DIPRO": 309.38, "VES": 5.46325, "VND": 23250.408139, "VUV": 116.804417, "WST": 2.663926, "XAF": 622.197133, "XAG": 0.0473384, "XAU": 0.00054739, "XCD": 2.70255, "XDR": 0.730404, "XMR": 0.0079577082, "XOF": 622.197133, "XPD": 0.00053149, "XPF": 113.190145, "XPT": 0.00109171, "XRP": 2.7337389273, "YER": 250.249998, "ZAR": 15.82326, "ZMW": 17.052572, "ZWL": 322, "NMC": 0.6583052534, "PPC": 1.2681920972, "NVC": 4.1334737071, "XPM": 4.8789734625, "EAC": 1463.0791964769, "VTC": 2.1090018835, "EMC": 15.3254221404, "FCT": 0.741747612]
    }
    
}
