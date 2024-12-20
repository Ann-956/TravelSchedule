import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        Button(action: {
            stationsTrain()
        }) {
            Text("Получить станции поездов")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        Button(action: {
            searchInfo()
        }) {
            Text("расписание между станциями")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        Button(action: {
            infoCarrier()
        }) {
            Text("информация о перевозчике")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        Button(action: {
            nearestSettlement()
        }) {
            Text("ближайший город")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        Button(action: {
            nearestSettlement()
        }) {
            Text("расписание рейсов по станции")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        Button(action: {
            threadStations()
        }) {
            Text("список станций следования")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        Button(action: {
            stationList()
        }) {
            Text("список всех станций")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        Button(action: {
            copyrightList()
        }) {
            Text("копирайт яндекса")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
    }
    func stationsTrain() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestStationsService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        Task {
            do {
                let request = NearestStationsServiceRequest(
                                lat: 59.864177,
                                lng: 30.319163,
                                distance: 30,
                                stationTypes: "train_station",
                                transportTypes: "train"
                            )
                let stations = try await service.getNearestStations(request: request)
                print("Станции:", stations)
            } catch {
                print("Ошибка при получении станций:", error)
            }
        }
    }
    
    func searchInfo() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = FlightsBetweenStationsService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: now)
        
        Task {
            do {
                let stationInfo = try await service.getFlightsBetweenStations(
                    from: "s9602494",
                    to: "s2006004",
                    date: currentDate
                )
                print("инфо", stationInfo)
            } catch {
                print("Ошибка при получении информации между станциями:", error)
            }
        }
    }
    
    func infoCarrier() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = InfoCarrierService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        Task {
            do {
                let infoCarrier = try await service.getInfoCarrier(
                    code: 129
                )
                print("инфо", infoCarrier)
            } catch {
                print("Ошибка при получении информации о перевозчике:", error)
            }
        }
    }
    
    func nearestSettlement() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        Task {
            do {
                let stations = try await service.getNearestSettlement(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 30
                )
                print("Город:", stations)
            } catch {
                print("Ошибка при получении станций:", error)
            }
        }
    }
    
    func scheduleByStation() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = ScheduleByStationService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = formatter.string(from: now)
        
        Task {
            do {
                let scheduleByStationInfo = try await service.getScheduleByStation(
                    station: "s9602494",
                    date: currentDate
                )
                print("инфо", scheduleByStationInfo)
            } catch {
                print("Ошибка при получении информации:", error)
            }
        }
    }
    
    func threadStations() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = ThreadStationsService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        Task {
            do {
                let threadStationsInfo = try await service.getThreadStations(
                    uid: "755A_0_2"
                )
                print("инфо", threadStationsInfo)
            } catch {
                print("Ошибка при получении информации:", error)
            }
        }
    }
    
    func stationList() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = StationListService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        Task {
            do {
                let stationListInfo = try await service.getStationList()
                print("инфо приходит")
            } catch {
                print("Ошибка при получении информации:", error)
            }
        }
    }
    
    func copyrightList() {
        let client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(
            client: client,
            apikey: Constants.yandexApiKey
        )
        
        Task {
            do {
                let copyrightInfo = try await service.getCopyrightYandex()
                print("инфо:", copyrightInfo)
            } catch {
                print("Ошибка при получении информации:", error)
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}
